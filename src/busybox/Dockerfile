ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG package=busybox
ARG CROSS_COMPILE=
ARG ARCH=
ARG NAME=

ENV CFLAGS=-static
ENV LDFLAGS=-static
ENV CPPFLAGS=-static
ENV CFLAGS_APPEND=-static
ENV LDFLAGS_APPEND=-static
ENV CPPFLAGS_APPEND=-static

COPY root/ /

RUN apt-get update && \
    apt-get build-dep -y ${package} && \
    chown -Rv _apt:root . && \
    apt-get source ${package}

RUN cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    cp /opt/busybox/custom.config . && \
    mkdir /dist && \
    make defconfig && \
    MAKEARGS=() && \
    if [ -n "$CROSS_COMPILE" ]; then MAKEARGS+=("CROSS_COMPILE=$CROSS_COMPILE"); fi && \
    if [ -n "$ARCH" ]; then MAKEARGS+=("ARCH=$ARCH"); fi && \
    make CONFIG=custom.config "${MAKEARGS[@]}" && cp busybox /dist/busybox.$NAME
