#!/bin/sh

build_root_build:
	docker build -t changtimwu/openwrt_buildroot -f Dockerfile.openwrt_buildroot .

build_root_push:
	docker push changtimwu/openwrt_buildroot

build_root_test:
	docker run -it --rm changtimwu/openwrt_buildroot bash
	
mvebu_sdk_build:
	docker build -t changtimwu/openwrt_mvebu_sdk  .

mvebu_sdk_push:
	docker push changtimwu/openwrt_mvebu_sdk

mveub_sdk_test:
	docker run -it -e WRTVER=lede --rm changtimwu/openwrt_mvebu_sdk bash

.PHONY: build_root_build build_root_push build_root_test mvebu_sdk_build mvebu_sdk_push mvebu_sdk_test
