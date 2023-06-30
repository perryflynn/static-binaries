ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG busyboxversion=0.60.3
ARG ARCH=amd64

RUN apk add build-base clang openssl-dev linux-headers && \
    apk add openssl-libs-static zlib-static || true && \
    apk add flex bison

RUN wget https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2 && \
    tar xvf busybox-${busyboxversion}.tar.bz2 && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ls -lisah && pwd && \
    make defconfig && \
    LDFLAGS="--static" make && \
    mkdir /dist && \
    cp busybox /dist/busybox.$ARCH
