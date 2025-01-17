ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG busyboxversion=1.37.0
ARG CHECKSUM=3311dff32e746499f4df0d5df04d7eb396382d7e108bb9250e7b519b837043a4
ARG ARCH=amd64
ARG PARALLEL=4

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2 \
        https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2.sig && \
    echo "$CHECKSUM busybox-${busyboxversion}.tar.bz2" | sha256sum -c && \
    bbchecksig.sh "denis.asc" "busybox-${busyboxversion}.tar.bz2.sig" "busybox-${busyboxversion}.tar.bz2" && \
    tar xvf busybox-${busyboxversion}.tar.bz2 && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    make defconfig && \
    LDFLAGS="--static" make -j${PARALLEL} && \
    mv busybox /dist/busybox.$ARCH && \
    strip /dist/busybox.$ARCH

RUN chmod a+x /dist/busybox.$ARCH && \
    /dist/busybox.$ARCH --help | head -n 1 > /dist/.version-busybox.$ARCH && \
    /dist/busybox.$ARCH --help
