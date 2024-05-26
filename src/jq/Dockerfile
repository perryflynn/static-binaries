ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG jqversion=1.7.1
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=478c9ca129fd2e3443fe27314b455e211e0d8c60bc8ff7df703873deeee580c2

RUN apk add --no-cache oniguruma oniguruma-dev

USER builduser

RUN wget https://github.com/jqlang/jq/releases/download/jq-${jqversion}/jq-${jqversion}.tar.gz && \
    echo "$CHECKSUM jq-${jqversion}.tar.gz" | sha256sum -c && \
    tar xvzf jq-${jqversion}.tar.gz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    ./configure --with-oniguruma && \
    make -j${PARALLEL} LDFLAGS=-all-static && \
    mv jq /dist/jq.$ARCH && \
    strip /dist/jq.$ARCH

RUN chmod a+x /dist/jq.$ARCH && \
    /dist/jq.$ARCH --version | head -n 1 > /dist/.version-jq.$ARCH && \
    /dist/jq.$ARCH --version && \
    /dist/jq.$ARCH --help
