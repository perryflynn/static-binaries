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
    apt-get install -y libncurses5-dev libncursesw5-dev vim && \
    apt-get build-dep -y ${package}

WORKDIR /src

RUN chown -Rv _apt:root . && \
    apt-get source ${package} && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    cp /opt/busybox/custom.config . && \
    make CONFIG=custom.config && \
    cp busybox /src
