#!/usr/bin/env bash

docker build -t buildkernel .
docker run -it \
  -v $(pwd)/common:/common \
  -v $(pwd)/out:/out \
  buildkernel \
  /bin/bash -c " \
    /common/scripts/1_fetch_kernel.sh ${1} && \
    /common/scripts/2_build_menuconfig.sh
  "
