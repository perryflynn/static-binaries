ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG busyboxversion=1.36.1
ARG ARCH=amd64

RUN wget https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2 && \
    tar xvf busybox-${busyboxversion}.tar.bz2 && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ls -lisah && pwd && \
    make defconfig && \
    LDFLAGS="--static" make && \
    mkdir /dist && \
    mv busybox /dist/busybox.$ARCH && \
    strip /dist/busybox.$ARCH
