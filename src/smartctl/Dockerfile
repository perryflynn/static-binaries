ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG smartmontoolsversion=7.4
ARG ARCH=amd64
ARG PARALLEL=4
ARG smartmontoolschecksum=e9a61f641ff96ca95319edfb17948cd297d0cd3342736b2c49c99d4716fb993d

RUN apk add --no-cache zstd-static lz4-static zstd-dev lz4-dev

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget -O smartmontools-${smartmontoolsversion}.tar.gz https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz/download && \
    wget -O smartmontools-${smartmontoolsversion}.tar.gz.asc https://sourceforge.net/projects/smartmontools/files/smartmontools/${smartmontoolsversion}/smartmontools-${smartmontoolsversion}.tar.gz.asc/download && \
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
