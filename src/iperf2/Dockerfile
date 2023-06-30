ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG iperfversion=2.1.9
ARG ARCH=amd64

RUN wget https://sourceforge.net/projects/iperf2/files/iperf-${iperfversion}.tar.gz/download && \
    tar xvzf download && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ./configure --enable-static-bin && \
    make && \
    mkdir /dist && \
    cp src/iperf /dist/iperf2.$ARCH
