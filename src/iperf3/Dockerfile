ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG iperfversion=3.20
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=3acc572d1ecca4e0b20359c7bf0132ddc80d982efeee20c86f6726a9a6094388

USER builduser

RUN wget https://github.com/esnet/iperf/releases/download/${iperfversion}/iperf-${iperfversion}.tar.gz && \
    echo -n "Checksum of downloaded file: " && sha256sum "iperf-${iperfversion}.tar.gz" && \
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
