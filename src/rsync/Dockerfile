#     1  wget https://github.com/Cyan4973/xxHash/archive/refs/tags/v0.8.2.tar.gz
#     2  tar xvzf v0.8.2.tar.gz
#     3  cd xxHash-0.8.2/
#     5  CFLAGS=-static make
#     7  cd ..
#     8  cp xxHash-0.8.2/libxxhash.* /usr/lib
#     9  wget https://download.samba.org/pub/rsync/src/rsync-3.2.7.tar.gz
#    10  cd tar xvzf rsync-3.2.7.tar.gz
#    11  tar xvzf rsync-3.2.7.tar.gz
#    12  cd rsync-3.2.7
#    13  ./configure CFLAGS="-static"
#    14* ./configure --[A
#    15  ./configure CFLAGS="-static"
#    16  apk add zstd-static lz4-static
#    17  ./configure CFLAGS="-static"
#    18  apk add zstd-static-dev lz4-static-dev
#    19  apk add zstd-dev lz4-dev
#    20  ./configure CFLAGS="-static"
#    21  cd /usr/lib/
#    23  cd ../include/
#    25  cp /src/xxHash-0.8.2/xxhash.* .
#    27  cd /src
#    28  cd rsync-3.2.7
#    29  ./configure CFLAGS="-static"
#    30  make
#    33  ./rsync --help
#    34  file rsync-ssl
#    35  cat rsync-ssl

ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG xxhashversion=0.8.2
ARG rsyncversion=3.2.7
ARG ARCH=amd64

RUN apk add oniguruma oniguruma-dev

USER builduser

RUN apk add zstd-static lz4-static zstd-dev lz4-dev

RUN wget https://github.com/Cyan4973/xxHash/archive/refs/tags/v${xxhashversion}.tar.gz && \
    tar xvzf v${xxhashversion}.tar.gz && \
    cd xxHash-${xxhashversion} && \
    ( CFLAGS=-static make ) && \
    cp libxxhash.* /usr/lib && \
    cp xxhash.* /usr/include

RUN wget https://download.samba.org/pub/rsync/src/rsync-${rsyncversion}.tar.gz && \
    tar xvzf rsync-${rsyncversion}.tar.gz && \
    cd rsync-${rsyncversion} && \
    ./configure CFLAGS="-static" && \
    make && \
    mv rsync /dist/rsync.$ARCH && \
    strip /dist/rsync.$ARCH

RUN chmod a+x /dist/rsync.$ARCH && \
    /dist/rsync.$ARCH --version | head -n 1 > /dist/.version-rsync.$ARCH && \
    /dist/rsync.$ARCH --version && \
    /dist/rsync.$ARCH --help
