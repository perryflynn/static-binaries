ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG iperfversion=3.18
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=c0618175514331e766522500e20c94bfb293b4424eb27d7207fb427b88d20bab

USER builduser

RUN wget https://github.com/esnet/iperf/releases/download/${iperfversion}/iperf-${iperfversion}.tar.gz && \
    echo "$CHECKSUM iperf-${iperfversion}.tar.gz" | sha256sum -c && \
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
