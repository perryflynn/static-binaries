ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG busyboxversion=1.36.1
ARG CHECKSUM=b8cc24c9574d809e7279c3be349795c5d5ceb6fdf19ca709f80cde50e47de314
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
