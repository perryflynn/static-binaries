ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG jqversion=1.6
ARG ARCH=amd64
ARG PARALLEL=4

RUN apk add --no-cache oniguruma oniguruma-dev

USER builduser

RUN wget https://github.com/jqlang/jq/releases/download/jq-${jqversion}/jq-${jqversion}.tar.gz && \
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
