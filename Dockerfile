FROM ubuntu:bionic AS wiiurpxtool-build
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        unzip \
        make \
        g++ \
        zlib1g-dev

RUN wget https://github.com/0CBH0/wiiurpxtool/archive/98935a5daf9a7629130974af3fa0c02bd6397bef.zip -O wiiurpxtool.zip
RUN unzip wiiurpxtool.zip
RUN cd wiiurpxtool-*/ && sed -i "s|#include <io.h>|#include <stdio.h>|g" wiiurpxtool.cpp && g++ wiiurpxtool.cpp -lz -o ../wiiurpxtool

FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        cmake \
        make \
        bsdmainutils \
        elfutils \
        wget \
        curl \
        ca-certificates \
        binutils \
        zlib1g-devel \
        g++ && \
    useradd -d /developer -m developer && \
    chown -R developer:developer /developer && \
    rm -rf /var/lib/apt/lists/*

ADD toolchain/devkitPPC_r29-1-x86_64-linux.tar.bz2 /opt/devkitpro

# the kind of hack I love - Arch packages can just be extracted into / and they
# work fine
ADD toolchain/ppc-libpng-1.6.37-1-any.pkg.tar.xz /
ADD toolchain/ppc-zlib-1.2.11-2-any.pkg.tar.xz /

COPY --from=wiiurpxtool-build /wiiurpxtool /usr/local/bin

ENV HOME=/developer
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
