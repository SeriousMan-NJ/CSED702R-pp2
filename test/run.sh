#!/bin/bash

for file in *.c
do
  echo "[COMPILE] $file"
  clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone $file
done

for file in *.ll
do
  echo "[PROCESS] $file"
  llc -load LLVMPP2.so -regalloc pp2 -pp2-dump-graph -debug $file &> /dev/null
done
