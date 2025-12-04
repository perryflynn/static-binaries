ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG iperfversion=2.2.1
ARG CHECKSUM=754ab0a7e28033dbea81308ef424bc7df4d6e2fe31b60cc536b61b51fefbd8fb

# -> Build

FROM ${BASEIMAGE} AS build
ARG ARCH PARALLEL iperfversion CHECKSUM

COPY /root /
RUN chown builduser:builduser -R /src

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://sourceforge.net/projects/iperf2/files/iperf-${iperfversion}.tar.gz/download /download/iperf-${iperfversion}.tar.gz && \
    echo -n "Checksum of downloaded file: " && sha256sum "/download/iperf-${iperfversion}.tar.gz" && \
    echo "$CHECKSUM /download/iperf-${iperfversion}.tar.gz" | sha256sum -c && \
    tar xvzf /download/iperf-${iperfversion}.tar.gz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    patch -p1 src/checksums.c < /src/musl-fix.patch && \
    ./configure && \
    make -j${PARALLEL} LDFLAGS=--static && \
    mv src/iperf /dist/iperf2.$ARCH && \
    bbstrip.sh /dist/iperf2.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH iperfversion

COPY --from=build /dist /dist

RUN chmod a+x /dist/iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version > /dist/.version-iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version && \
    /dist/iperf2.$ARCH --help && \
    BINARY=/dist/iperf2.$ARCH VERSION=$iperfversion VERSIONINFO=/dist/.version-iperf2.$ARCH bbensurebuild.sh
