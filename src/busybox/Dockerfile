ARG BASEIMAGE

FROM ${BASEIMAGE}

ARG package=busybox
ARG CROSS_COMPILE=
ARG ARCH=

ENV CFLAGS=-static
ENV LDFLAGS=-static
ENV CPPFLAGS=-static
ENV CFLAGS_APPEND=-static
ENV LDFLAGS_APPEND=-static
ENV CPPFLAGS_APPEND=-static

COPY root/ /

RUN apt-get build-dep -y ${package}

WORKDIR /src
SHELL [ "/bin/bash", "-c" ]

RUN chown -Rv _apt:root . && \
    apt-get source ${package}

RUN cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    cp /opt/busybox/custom.config . && \
    mkdir /dist && \
    make defconfig && \
    ( if [ "$CROSS_COMPILE" == "." ]; then CROSS_COMPILE=""; fi ) && \
    ( if [ "$ARCH" == "." ]; then ARCH=""; fi ) && \
    make CONFIG=custom.config CROSS_COMPILE=$CROSS_COMPILE ARCH=$ARCH && cp busybox /dist/busybox.$ARCH
