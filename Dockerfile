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
        ca-certificates && \
    useradd -d /developer -m developer && \
    chown -R developer:developer /developer && \
    rm -rf /var/lib/apt/lists/*

ADD toolchain/devkitPPC_r29-1-x86_64-linux.tar.bz2 /opt/devkitpro

# the kind of hack I love - Arch packages can just be extracted into / and they
# work fine
ADD toolchain/ppc-libpng-1.6.37-1-any.pkg.tar.xz /
ADD toolchain/ppc-zlib-1.2.11-2-any.pkg.tar.xz /

ENV HOME=/developer
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
