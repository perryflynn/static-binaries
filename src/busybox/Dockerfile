FROM reg.git.brickburg.de/bbcontainers/hub/debian:bookworm-slim

ARG package=busybox

ENV CFLAGS=-static
ENV LDFLAGS=-static
ENV CPPFLAGS=-static
ENV CFLAGS_APPEND=-static
ENV LDFLAGS_APPEND=-static
ENV CPPFLAGS_APPEND=-static

COPY root/ /

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y libncurses5-dev libncursesw5-dev vim \
        gcc make gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu \
        gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi && \
    apt-get build-dep -y ${package}

WORKDIR /src

RUN chown -Rv _apt:root . && \
    apt-get source ${package}

RUN cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    cp /opt/busybox/custom.config . && \
    make defconfig && \
    make CONFIG=custom.config && cp busybox /src/busybox.86_64 && \
    make CONFIG=custom.config CROSS_COMPILE=aarch64-linux-gnu- ARCH=aarch64 && cp busybox /src/busybox.aarch64 && \
    make CONFIG=custom.config CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm && cp busybox /src/busybox.arm
