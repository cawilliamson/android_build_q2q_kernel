#!/usr/bin/env bash

docker build -t buildkernel .
docker run \
  -v $(pwd)/common:/common \
  -v $(pwd)/out:/out \
  buildkernel \
  /bin/bash -c " \
    /common/scripts/1_fetch_kernel.sh $1 $2 && \
    /common/scripts/2_build_kernel.sh && \
    /common/scripts/3_build_zip.sh && \
    /common/scripts/4_fix_permissions.sh \
  "
