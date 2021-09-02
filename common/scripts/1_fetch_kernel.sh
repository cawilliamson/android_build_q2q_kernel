#!/usr/bin/env bash

# fetch kernel sources
git clone \
  -b ${1:-master} \
  https://github.com/cawilliamson/android_kernel_samsung_q2q \
  /usr/src/kernel
