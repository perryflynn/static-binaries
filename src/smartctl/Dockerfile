ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG smartmontoolsversion=7.5
ARG ARCH=amd64
ARG PARALLEL=4
ARG smartmontoolschecksum=690b83ca331378da9ea0d9d61008c4b22dde391387b9bbad7f29387f2595f76e

RUN apk add --no-cache zstd-static lz4-static zstd-dev lz4-dev

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget -O smartmontools-${smartmontoolsversion}.tar.gz https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz/download && \
    wget -O smartmontools-${smartmontoolsversion}.tar.gz.asc https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz.asc/download && \
    echo -n "Checksum of downloaded file: " && sha256sum "smartmontools-${smartmontoolsversion}.tar.gz" && \
    echo "$smartmontoolschecksum smartmontools-${smartmontoolsversion}.tar.gz" | sha256sum -c && \
    bbchecksig.sh "smartmontools.asc" "smartmontools-${smartmontoolsversion}.tar.gz.asc" "smartmontools-${smartmontoolsversion}.tar.gz" && \
    tar xvzf smartmontools-${smartmontoolsversion}.tar.gz && \
    cd smartmontools-${smartmontoolsversion} && \
    ./configure CFLAGS="-static" && \
    make -j${PARALLEL} CFLAGS="-static"  LDFLAGS=--static && \
    mv smartctl /dist/smartctl.$ARCH && \
    strip /dist/smartctl.$ARCH

RUN chmod a+x /dist/smartctl.$ARCH && \
    /dist/smartctl.$ARCH --version | head -n 1 > /dist/.version-smartctl.$ARCH && \
    /dist/smartctl.$ARCH --version && \
    /dist/smartctl.$ARCH --help
