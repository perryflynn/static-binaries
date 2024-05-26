ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG xxhashversion=0.8.2
ARG rsyncversion=3.3.0
ARG ARCH=amd64
ARG PARALLEL=4
ARG xxhashchecksum=baee0c6afd4f03165de7a4e67988d16f0f2b257b51d0e3cb91909302a26a79c4
ARG rsyncchecksum=7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90

RUN apk add --no-cache zstd-static lz4-static zstd-dev lz4-dev

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
    bbchecksig.sh "wayne.asc" "rsync-${rsyncversion}.tar.gz.asc" "rsync-${rsyncversion}.tar.gz" && \
    tar xvzf rsync-${rsyncversion}.tar.gz && \
    cd rsync-${rsyncversion} && \
    ./configure CFLAGS="-static" && \
    make -j${PARALLEL} && \
    mv rsync /dist/rsync.$ARCH && \
    strip /dist/rsync.$ARCH

RUN chmod a+x /dist/rsync.$ARCH && \
    /dist/rsync.$ARCH --version | head -n 1 > /dist/.version-rsync.$ARCH && \
    /dist/rsync.$ARCH --version && \
    /dist/rsync.$ARCH --help
