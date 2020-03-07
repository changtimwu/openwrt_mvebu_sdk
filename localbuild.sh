#!/bin/sh
docker build -t changtimwu/openwrt_mvebu_sdk  .
echo "test with    docker run -it --rm changtimwu/openwrt_mvebu_sdk bash"
#echo "test with docker run -it -e WRTVER=lede --rm changtimwu/openwrt_mvebu_sdk bash"
echo "push with    docker push changtimwu/openwrt_mvebu_sdk"
