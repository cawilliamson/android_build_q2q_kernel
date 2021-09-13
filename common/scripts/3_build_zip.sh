#!/usr/bin/env bash

ARCH=arm64
PROJECT_NAME=q2q
export ARCH PROJECT_NAME

BUILD_CROSS_COMPILE="/opt/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
CLANG_TRIPLE="aarch64-linux-gnu-"
KERNEL_LLVM_BIN="/opt/qcom-clang/bin/clang"
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

# fetch anykernel3 sources
git clone \
  https://github.com/osm0sis/AnyKernel3.git \
  /usr/src/anykernel3

# create modules directory structure
rm -rfv /usr/src/anykernel3/modules/*
mkdir -p /usr/src/anykernel3/modules/vendor/lib/modules

# create config
cp -fv /common/configs/anykernel.sh /usr/src/anykernel3/anykernel.sh

# gzip kernel image (and copy at the same time)
gzip -9 -c /usr/src/kernel/out/arch/arm64/boot/Image > /usr/src/anykernel3/Image.gz

# Install modules to anykernel3 modules/ dir
pushd /usr/src/kernel
  make -C $(pwd) \
  O=$(pwd)/out \
  $KERNEL_MAKE_ENV \
  CLANG_TRIPLE=$CLANG_TRIPLE \
  CONFIG_SECTION_MISMATCH_WARN_ONLY=y \
  CROSS_COMPILE=$BUILD_CROSS_COMPILE \
  INSTALL_MOD_PATH=/usr/src/anykernel3/modules/vendor \
  REAL_CC=$KERNEL_LLVM_BIN \
  modules_install
popd

# cleanup previous zips
rm -f /out/*.zip

# create zip file
pushd /usr/src/anykernel3
  zip -r9 --symlinks /out/leanKernel.zip . -x .git README.md *placeholder
popd
