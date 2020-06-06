add_llvm_library(LLVMPP2 MODULE
  InterferenceGraph.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/CodeGen

  LINK_LIBS ${LLVM_PTHREAD_LIB}

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  llc
  )
