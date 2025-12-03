ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG xxhashversion=0.8.3
ARG rsyncversion=3.4.1
ARG ARCH=amd64
ARG PARALLEL=4
ARG xxhashchecksum=aae608dfe8213dfd05d909a57718ef82f30722c392344583d3f39050c7f29a80
ARG rsyncchecksum=2924bcb3a1ed8b551fc101f740b9f0fe0a202b115027647cf69850d65fd88c52

RUN apk add --no-cache zstd-static zstd-dev lz4-static lz4-dev acl-static acl-dev attr-static attr-dev

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget https://github.com/Cyan4973/xxHash/archive/refs/tags/v${xxhashversion}.tar.gz && \
    echo "$xxhashchecksum v${xxhashversion}.tar.gz" | sha256sum -c && \
    tar xvzf v${xxhashversion}.tar.gz && \
    cd xxHash-${xxhashversion} && \
    make -j${PARALLEL}

USER root

RUN cd xxHash-${xxhashversion} && \
    cp libxxhash.* /usr/lib && \
    cp xxhash.* /usr/include

USER builduser

RUN wget https://download.samba.org/pub/rsync/src/rsync-${rsyncversion}.tar.gz \
        https://download.samba.org/pub/rsync/src/rsync-${rsyncversion}.tar.gz.asc && \
    echo "$rsyncchecksum rsync-${rsyncversion}.tar.gz" | sha256sum -c && \
    bbchecksig.sh "tridge.asc" "rsync-${rsyncversion}.tar.gz.asc" "rsync-${rsyncversion}.tar.gz" && \
    tar xvzf rsync-${rsyncversion}.tar.gz && \
    cd rsync-${rsyncversion} && \
    ./configure CFLAGS="-static" --enable-acl-support=yes --enable-xattr-support=yes \
        --enable-xxhash=yes --enable-zstd=yes --enable-lz4=yes --enable-openssl=yes \
        --enable-ipv6=yes --enable-largefile=yes --enable-locale=yes \
        --enable-iconv-open=yes --enable-iconv=yes && \
    make -j${PARALLEL} && \
    mv rsync /dist/rsync.$ARCH && \
    strip /dist/rsync.$ARCH

RUN chmod a+x /dist/rsync.$ARCH && \
    /dist/rsync.$ARCH --version | head -n 1 > /dist/.version-rsync.$ARCH && \
    /dist/rsync.$ARCH --version && \
    /dist/rsync.$ARCH --help && \
    BINARY=/dist/rsync.$ARCH VERSION=$rsyncversion VERSIONINFO=/dist/.version-rsync.$ARCH bbensurebuild.sh && \
    /src/tests.sh
