FROM reg.git.brickburg.de/bbcontainers/hub/debian:bookworm-slim

ARG package=busybox

COPY root/ /

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get build-dep ${package}

WORKDIR /src

RUN apt-get source --build ${package}
