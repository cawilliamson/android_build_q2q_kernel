#!/usr/bin/env bash

# fetch anykernel3 sources
git clone \
  https://github.com/osm0sis/AnyKernel3.git \
  /usr/src/anykernel3

# remove example modules directory structure
rm -rfv /usr/src/anykernel3/modules/*

# create config
cp -fv /common/configs/anykernel.sh /usr/src/anykernel3/anykernel.sh

# gzip kernel image (and copy at the same time)
gzip -9 -c /usr/src/kernel/out/arch/arm64/boot/Image > /usr/src/anykernel3/Image.gz

# find + copy modules to zip and generate module.load list
mkdir -p /usr/src/anykernel3/modules/vendor/lib/modules/
find /usr/src/kernel/out -type f -name '*.ko' -exec \
  cp -v "{}" "/usr/src/anykernel3/modules/vendor/lib/modules/" \;
ls -1 /usr/src/anykernel3/modules/vendor/lib/modules/*.ko | xargs -n1 basename > /usr/src/anykernel3/modules/vendor/lib/modules/modules.load

# cleanup previous zips
rm -f /out/*.zip

# create zip file
pushd /usr/src/anykernel3
  zip -r9 /out/leanKernel.zip * -x .git README.md *placeholder
popd
