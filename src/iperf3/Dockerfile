ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG iperfversion=3.17.1
ARG ARCH=amd64
ARG PARALLEL=4

USER builduser

RUN wget https://downloads.es.net/pub/iperf/iperf-${iperfversion}.tar.gz && \
    tar xvzf iperf-${iperfversion}.tar.gz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ./configure --enable-static --enable-static-bin && \
    make -j${PARALLEL} && \
    mv src/iperf3 /dist/iperf3.$ARCH && \
    strip /dist/iperf3.$ARCH

RUN chmod a+x /dist/iperf3.$ARCH && \
    /dist/iperf3.$ARCH --version | head -n 1 > /dist/.version-iperf3.$ARCH && \
    /dist/iperf3.$ARCH --version && \
    /dist/iperf3.$ARCH --help
