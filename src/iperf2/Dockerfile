ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG iperfversion=2.2.1
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=754ab0a7e28033dbea81308ef424bc7df4d6e2fe31b60cc536b61b51fefbd8fb

COPY /root /
RUN chown builduser:builduser -R /src

USER builduser

RUN wget https://sourceforge.net/projects/iperf2/files/iperf-${iperfversion}.tar.gz/download && \
    echo -n "Checksum of downloaded file: " && sha256sum "download" && \
    echo "$CHECKSUM download" | sha256sum -c && \
    tar xvzf download && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    patch -p1 src/checksums.c < /src/musl-fix.patch && \
    ./configure && \
    make -j${PARALLEL} LDFLAGS=--static && \
    mv src/iperf /dist/iperf2.$ARCH && \
    strip /dist/iperf2.$ARCH

RUN chmod a+x /dist/iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version > /dist/.version-iperf2.$ARCH && \
    /dist/iperf2.$ARCH --version && \
    /dist/iperf2.$ARCH --help && \
    BINARY=/dist/iperf2.$ARCH VERSION=$iperfversion VERSIONINFO=/dist/.version-iperf2.$ARCH bbensurebuild.sh
