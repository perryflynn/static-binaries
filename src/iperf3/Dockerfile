ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG iperfversion=3.20
ARG CHECKSUM=3acc572d1ecca4e0b20359c7bf0132ddc80d982efeee20c86f6726a9a6094388

# -> Build

FROM ${BASEIMAGE} AS build
ARG ARCH PARALLEL iperfversion CHECKSUM

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://github.com/esnet/iperf/releases/download/${iperfversion}/iperf-${iperfversion}.tar.gz /download/iperf-${iperfversion}.tar.gz && \
    echo -n "Checksum of downloaded file: " && sha256sum "/download/iperf-${iperfversion}.tar.gz" && \
    echo "$CHECKSUM /download/iperf-${iperfversion}.tar.gz" | sha256sum -c && \
    tar xzf /download/iperf-${iperfversion}.tar.gz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ./configure --enable-static --enable-static-bin && \
    make -j${PARALLEL} && \
    mv src/iperf3 /dist/iperf3.$ARCH && \
    bbstrip.sh /dist/iperf3.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH iperfversion

COPY --from=build /dist /dist

RUN chmod a+x /dist/iperf3.$ARCH && \
    /dist/iperf3.$ARCH --version | head -n 1 > /dist/.version-iperf3.$ARCH && \
    /dist/iperf3.$ARCH --version && \
    /dist/iperf3.$ARCH --help && \
    BINARY=/dist/iperf3.$ARCH VERSION=$iperfversion VERSIONINFO=/dist/.version-iperf3.$ARCH bbensurebuild.sh
