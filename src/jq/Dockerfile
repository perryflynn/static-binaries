ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG jqversion=1.8.1
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=2be64e7129cecb11d5906290eba10af694fb9e3e7f9fc208a311dc33ca837eb0

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
    /dist/jq.$ARCH --help && \
    BINARY=/dist/jq.$ARCH VERSION=$jqversion VERSIONINFO=/dist/.version-jq.$ARCH bbensurebuild.sh
