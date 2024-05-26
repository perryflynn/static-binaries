ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG xxhashversion=0.8.2
ARG rsyncversion=3.3.0
ARG ARCH=amd64
ARG PARALLEL=4

RUN apk add --no-cache zstd-static lz4-static zstd-dev lz4-dev

USER builduser

RUN wget https://github.com/Cyan4973/xxHash/archive/refs/tags/v${xxhashversion}.tar.gz && \
    tar xvzf v${xxhashversion}.tar.gz && \
    cd xxHash-${xxhashversion} && \
    make -j${PARALLEL}

USER root

RUN cd xxHash-${xxhashversion} && \
    cp libxxhash.* /usr/lib && \
    cp xxhash.* /usr/include

USER builduser

RUN wget https://download.samba.org/pub/rsync/src/rsync-${rsyncversion}.tar.gz && \
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
