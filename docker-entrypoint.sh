#!/bin/bash
if [ "$WRTVER" = "lede" ]; then
    echo "LEDE env"
    TLTAR=$TLTARB2
else
    echo "Standard env"
    TLTAR=$TLTARB
fi
TLDN=`basename -s .tar.xz $TLTAR`
BINDIR=$(dirname $(find ${TLPATH}/${TLDN} -name "arm-openwrt-linux-gcc" -print))

cd $BINDIR
if [ ! -e arm-openwrt-linux-cc ]; then
    ln -s arm-openwrt-linux-gcc arm-openwrt-linux-cc
fi

if [ "$WRTVER" = "lede" ]; then
    cd $TLPATH
    ln -s $TLDN/staging_dir/toolchain-arm_cortex-a9+vfpv3_gcc-5.4.0_musl-1.1.16_eabi/ .
fi 

export PATH="$BINDIR:$PATH"
export STAGING_DIR=$(find ${TLPATH}/${TLDN}  -name "staging_dir")
cd
exec "$@"
