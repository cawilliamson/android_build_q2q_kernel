#!/usr/bin/env bash

# change working directory
cd /usr/src/kernel

# execute actual build
bash build_menuconfig.sh

# remove previous defconfig
rm -f /out/defconfig

# copy kernel image out
cp -fv \
  /usr/src/kernel/out/.config \
  /out/defconfig
