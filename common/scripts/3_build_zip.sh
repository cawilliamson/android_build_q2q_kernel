#!/usr/bin/env bash

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

# create zip file
pushd /usr/src/anykernel3
  zip -r9 /out/leanKernel.zip * -x .git README.md *placeholder
popd
