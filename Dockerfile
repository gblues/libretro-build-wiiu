FROM ubuntu:bionic

ARG uid
ARG branch=develop
ENV branch=$branch

RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        unzip \
        git \
        cmake \
        make \
        bsdmainutils \
        elfutils \
        binutils \
        zlib1g-dev \
        wget \
        curl \
        gcc \
        g++ && \
    useradd -d /developer -m developer && \
    chown -R developer:developer /developer && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/libretro/libretro-toolchains/raw/master/wiiu.tar.xz /opt/wiiu.tar.xz
RUN tar xf /opt/wiiu.tar.xz -C /opt

ENV HOME=/developer
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
