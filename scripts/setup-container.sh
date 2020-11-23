#!/bin/bash
docker run -d \
    -it \
    --name arm64 \
    --network="host" \
    --mount type=bind,source="$(pwd)"/opt,target=/root/opt \
    arm64v8/centos
