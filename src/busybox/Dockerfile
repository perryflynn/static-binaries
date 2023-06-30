ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG busyboxversion=0.60.3
ARG ARCH=amd64

RUN apk add build-base clang openssl-dev linux-headers && \
    apk add openssl-libs-static zlib-static || true && \
    apk add flex bison

COPY root/ /

RUN wget https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2 && \
    tar xvf busybox-${busyboxversion}.tar.bz2 && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    cp /opt/busybox/custom.config . && \
    ls -lisah && pwd && \
    mkdir /dist && \
    make defconfig && \
    make CONFIG=custom.config && cp busybox /dist/busybox.$ARCH
