ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG smartmontoolsversion=7.5
ARG smartmontoolschecksum=690b83ca331378da9ea0d9d61008c4b22dde391387b9bbad7f29387f2595f76e

# -> Build

FROM ${BASEIMAGE} AS build
ARG ARCH PARALLEL smartmontoolsversion smartmontoolschecksum

RUN apk add --no-cache zstd-static lz4-static zstd-dev lz4-dev

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz/download /download/smartmontools-${smartmontoolsversion}.tar.gz && \
    bbwget.sh https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz.asc/download /download/smartmontools-${smartmontoolsversion}.tar.gz.asc && \
    echo -n "Checksum of downloaded file: " && sha256sum "/download/smartmontools-${smartmontoolsversion}.tar.gz" && \
    echo "$smartmontoolschecksum /download/smartmontools-${smartmontoolsversion}.tar.gz" | sha256sum -c && \
    bbchecksig.sh "smartmontools.asc" "/download/smartmontools-${smartmontoolsversion}.tar.gz.asc" "/download/smartmontools-${smartmontoolsversion}.tar.gz" && \
    tar xzf /download/smartmontools-${smartmontoolsversion}.tar.gz && \
    cd smartmontools-${smartmontoolsversion} && \
    ./configure CFLAGS="-static" && \
    make -j${PARALLEL} CFLAGS="-static"  LDFLAGS=--static && \
    mv smartctl /dist/smartctl.$ARCH && \
    bbstrip.sh /dist/smartctl.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH smartmontoolsversion

COPY --from=build /dist /dist

RUN chmod a+x /dist/smartctl.$ARCH && \
    /dist/smartctl.$ARCH --version | head -n 1 > /dist/.version-smartctl.$ARCH && \
    /dist/smartctl.$ARCH --version && \
    /dist/smartctl.$ARCH --help && \
    BINARY=/dist/smartctl.$ARCH VERSION=$smartmontoolsversion VERSIONINFO=/dist/.version-smartctl.$ARCH bbensurebuild.sh
