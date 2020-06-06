//===-- InterferenceGraph.cpp ---------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This pass collects the count of all instructions and reports them
//
//===----------------------------------------------------------------------===//

#include "Graph.h"
#include "../Spiller.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/Passes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/InitializePasses.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/CodeGen/CalcSpillWeights.h"
#include "llvm/CodeGen/LiveInterval.h"
#include "llvm/CodeGen/LiveIntervals.h"
#include "llvm/CodeGen/LiveRangeEdit.h"
#include "llvm/CodeGen/LiveStacks.h"
#include "llvm/CodeGen/MachineBlockFrequencyInfo.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/RegAllocRegistry.h"
#include "llvm/CodeGen/PP2Registry.h"
#include "llvm/CodeGen/SlotIndexes.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/CodeGen/VirtRegMap.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include <algorithm>
#include <cassert>
#include <cstddef>
#include <limits>
#include <map>
#include <memory>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <system_error>
#include <tuple>
#include <utility>
#include <vector>
using namespace llvm;

#define DEBUG_TYPE "pp2"

// static RegisterPP2 pp2RegAlloc("pp2", "pp2 register allocator",
//                                createInterferenceGraphPass);

static RegisterRegAlloc pp2RegAlloc("pp2", "pp2 register allocator",
                               createInterferenceGraphPass);

#ifndef NDEBUG
static cl::opt<bool>
PP2DumpGraphs("pp2-dump-graph",
               cl::desc("Dump interference graph"),
               cl::init(false), cl::Hidden);
#endif

namespace {
  class InterferenceGraph : public MachineFunctionPass {
  public:
    static char ID; // Pass identification, replacement for typeid
    InterferenceGraph() : MachineFunctionPass(ID) { }

    /// Return the pass name.
    StringRef getPassName() const override { return "PP2 Register Allocator"; }

    void getAnalysisUsage(AnalysisUsage &au) const override;
    bool runOnMachineFunction(MachineFunction &F) override;

  private:
    using RegSet = std::set<unsigned>;

    RegSet VRegsToAlloc, EmptyIntervalVRegs;
    SmallPtrSet<MachineInstr *, 32> DeadRemats;

    /// Finds the initial set of vreg intervals to allocate.
    void findVRegIntervalsToAlloc(const MachineFunction &F, LiveIntervals &LIS);

    /// Constructs an initial graph.
    void initializeGraph(PP2::Graph &G, VirtRegMap &VRM, Spiller &VRegSpiller);

    /// Spill the given VReg.
    void spillVReg(unsigned VReg, SmallVectorImpl<unsigned> &NewIntervals,
                   MachineFunction &MF, LiveIntervals &LIS, VirtRegMap &VRM,
                   Spiller &VRegSpiller);
  };
}

void InterferenceGraph::getAnalysisUsage(AnalysisUsage &au) const {
  au.setPreservesCFG();
  au.addRequired<AAResultsWrapperPass>();
  au.addPreserved<AAResultsWrapperPass>();
  au.addRequired<SlotIndexes>();
  au.addPreserved<SlotIndexes>();
  au.addRequired<LiveIntervals>();
  au.addPreserved<LiveIntervals>();
  au.addRequired<LiveStacks>();
  au.addPreserved<LiveStacks>();
  au.addRequired<MachineBlockFrequencyInfo>();
  au.addPreserved<MachineBlockFrequencyInfo>();
  au.addRequired<MachineLoopInfo>();
  au.addPreserved<MachineLoopInfo>();
  au.addRequired<MachineDominatorTree>();
  au.addPreserved<MachineDominatorTree>();
  au.addRequired<VirtRegMap>();
  au.addPreserved<VirtRegMap>();
  MachineFunctionPass::getAnalysisUsage(au);
}

char InterferenceGraph::ID = 0;
// static RegisterPass<InterferenceGraph> X("pp2", "Interference Graph");

FunctionPass *llvm::createInterferenceGraphPass() { return new InterferenceGraph(); }

void InterferenceGraph::findVRegIntervalsToAlloc(const MachineFunction &MF,
                                          LiveIntervals &LIS) {
  const MachineRegisterInfo &MRI = MF.getRegInfo();

  // Iterate over all live ranges.
  for (unsigned I = 0, E = MRI.getNumVirtRegs(); I != E; ++I) {
    unsigned Reg = Register::index2VirtReg(I);
    if (MRI.reg_nodbg_empty(Reg))
      continue;
    VRegsToAlloc.insert(Reg);
  }
}

void InterferenceGraph::initializeGraph(PP2::Graph &G, VirtRegMap &VRM,
                                        Spiller &VRegSpiller) {
  LiveIntervals &LIS = G.LIS;

  for (auto VReg : VRegsToAlloc) {
    // Move empty intervals to the EmptyIntervalVReg set.
    if (LIS.getInterval(VReg).empty()) {
      EmptyIntervalVRegs.insert(VReg);
      VRegsToAlloc.erase(VReg);
      continue;
    }

    PP2::Graph::NodeId NId = G.addNodeForVReg(VReg);
    G.setNodeIdForVReg(VReg, NId);
  }

  for (auto VReg1 : VRegsToAlloc) {
    for (auto VReg2 : VRegsToAlloc) {
      if (VReg1 != VReg2 && LIS.getInterval(VReg1).overlaps(LIS.getInterval(VReg2))) {
        G.addEdgeForVReg(VReg1, VReg2);
      }
    }
  }
}

void PP2::Graph::dump(raw_ostream &OS) const {
  const MachineRegisterInfo &MRI = MF.getRegInfo();
  const TargetRegisterInfo *TRI = MRI.getTargetRegisterInfo();
  for (auto N : Nodes) {
    OS << N.NId << " (" << printReg(N.VReg, TRI) << ")" << ": ";
    for (auto AdjN : N.adjNodes) {
      OS << AdjN << " ";
    }
    OS << "\n";
  }
}

bool InterferenceGraph::runOnMachineFunction(MachineFunction &MF) {
  LiveIntervals &LIS = getAnalysis<LiveIntervals>();
  VirtRegMap &VRM = getAnalysis<VirtRegMap>();

  std::unique_ptr<Spiller> VRegSpiller(createInlineSpiller(*this, MF, VRM));
  MF.getRegInfo().freezeReservedRegs(MF);

  LLVM_DEBUG(dbgs() << "[PP2] start!\n");

  // Find the vreg intervals in need of allocation.
  findVRegIntervalsToAlloc(MF, LIS);

#ifndef NDEBUG
  const Function &F = MF.getFunction();
  std::string FullyQualifiedName =
    F.getParent()->getModuleIdentifier() + "." + F.getName().str();
#endif

  if (!VRegsToAlloc.empty()) {
    PP2::Graph G(MF, LIS);
    initializeGraph(G, VRM, *VRegSpiller);

#ifndef NDEBUG
  if (PP2DumpGraphs) {
    std::ostringstream RS;
    std::string GraphFileName = FullyQualifiedName + "." + RS.str() +
                                ".pp2graph";
    std::error_code EC;
    raw_fd_ostream OS(GraphFileName, EC, sys::fs::OF_Text);
    LLVM_DEBUG(dbgs() << "Dumping graph to \""
                      << GraphFileName << "\"\n");
    G.dump(OS);
  }
#endif
  }

  LLVM_DEBUG(dbgs() << "[PP2] end!\n");

  return true;
}
