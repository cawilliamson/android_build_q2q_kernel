#!/usr/bin/env bash

# change working directory
cd /usr/src/kernel

ARCH=arm64
PROJECT_NAME=q2q
export ARCH PROJECT_NAME

BUILD_CROSS_COMPILE="/opt/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
CLANG_TRIPLE="aarch64-linux-gnu-"
KERNEL_LLVM_BIN="/opt/qcom-clang/bin/clang"
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

mkdir -p out/

make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  CONFIG_SECTION_MISMATCH_WARN_ONLY=y \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  vendor/q2q_eur_openx_defconfig

make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  CONFIG_SECTION_MISMATCH_WARN_ONLY=y \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  REAL_CC=$KERNEL_LLVM_BIN \
  CONFIG_SECTION_MISMATCH_WARN_ONLY=y \
  menuconfig

# remove previous defconfig
rm -f /out/defconfig

# copy kernel image out
cp -fv \
  /usr/src/kernel/out/.config \
  /out/defconfig
