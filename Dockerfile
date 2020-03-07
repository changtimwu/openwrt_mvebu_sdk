FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
  xz-utils \
  make vim \
  unzip \
  curl \
  flex gawk \
  build-essential gcc-5 \
  libfl2 bison \
  git jq wget libncurses5-dev \
  zlib1g-dev mtd-utils samba-client  \
  libcurl4-openssl-dev gnutls-bin \
  cpio sshpass iputils-ping \
  u-boot-tools tzdata
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10; update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 20; update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30;update-alternatives --set cc /usr/bin/gcc
ENV TLPATH /opt/toolchains
ENV TLTARB openwrt-sdk-18.06.5-mvebu-cortexa9_gcc-7.3.0_musl_eabi.Linux-x86_64.tar.xz
ENV TLTARB2 lede-sdk-17.01.6-mvebu_gcc-5.4.0_musl-1.1.16_eabi.Linux-x86_64.tar.xz
ENV MVTLTARB armv7-marvell-linux-gnueabi-softfp-4.6.4_64K_i686_20160226.tar.xz

RUN mkdir -p $TLPATH
COPY unpackonce.sh $TLPATH/
COPY $TLTARB $TLPATH/
RUN cd $TLPATH && ./unpackonce.sh $TLTARB
COPY $TLTARB2 $TLPATH/
RUN cd $TLPATH && ./unpackonce.sh $TLTARB2
COPY $MVTLTARB $TLPATH/
RUN cd $TLPATH && ./unpackonce.sh $MVTLTARB

ENV SRCDIR /opt/src
ENV MVKSRCTARB linux-4.4_marvell_ac3_a385_openwrt.tar.xz
ENV MVKSRCD /opt/src/linux-4.4_marvell_ac3_a385_openwrt/
RUN mkdir -p $SRCDIR
COPY unpackonce.sh $SRCDIR/
COPY $MVKSRCTARB $SRCDIR/
RUN cd $SRCDIR && ./unpackonce.sh $MVKSRCTARB

RUN cd /usr/bin/ && ln -s make gmake

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
