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

# create config
cp -fv /common/configs/anykernel.sh /usr/src/anykernel3/anykernel.sh

# gzip kernel image (and copy at the same time)
gzip -9 -c /usr/src/kernel/out/arch/arm64/boot/Image > /usr/src/anykernel3/Image.gz

# cleanup previous zips
rm -f /out/*.zip

# remove junk before zipping
find /usr/src/anykernel -type f -name 'placeholder' -delete
rm -rf /usr/src/anykernel3/.git /usr/src/anykernel3/README.md

# create zip file
pushd /usr/src/anykernel3
  zip -r -y -9 /out/leanKernel.zip .
popd
