ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG iperfversion=2.2.0
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=16810a9575e4c6dd65e4a18ab5df3cdac6730b3c832cf080a8990f132f68364a

USER builduser

RUN wget https://sourceforge.net/projects/iperf2/files/iperf-${iperfversion}.tar.gz/download && \
    echo "$CHECKSUM download" | sha256sum -c && \
    tar xvzf download && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ./configure --enable-static-bin && \
    make -j${PARALLEL} && \
    mv src/iperf /dist/iperf2.$ARCH && \
    strip /dist/iperf2.$ARCH

RUN chmod a+x /dist/iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version > /dist/.version-iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version && \
    /dist/iperf2.$ARCH --help
