ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG busyboxversion=1.37.0
ARG CHECKSUM=3311dff32e746499f4df0d5df04d7eb396382d7e108bb9250e7b519b837043a4

# -> Build

FROM ${BASEIMAGE} AS build
ARG busyboxversion CHECKSUM ARCH PARALLEL

WORKDIR /src

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2 /download/busybox-${busyboxversion}.tar.bz2 && \
    bbwget.sh https://busybox.net/downloads/busybox-${busyboxversion}.tar.bz2.sig /download/busybox-${busyboxversion}.tar.bz2.sig && \
    echo "$CHECKSUM /download/busybox-${busyboxversion}.tar.bz2" | sha256sum -c && \
    bbchecksig.sh "denis.asc" "/download/busybox-${busyboxversion}.tar.bz2.sig" "/download/busybox-${busyboxversion}.tar.bz2" && \
    tar xvf /download/busybox-${busyboxversion}.tar.bz2 && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    patch -p1 libbb/hash_md5_sha.c < /src/aarch64-libbbb.patch && \
    make defconfig && \
    LDFLAGS="--static" make -j${PARALLEL} && \
    mv busybox /dist/busybox.$ARCH && \
    bbstrip.sh /dist/busybox.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH busyboxversion

COPY root/ /
RUN chown builduser:builduser /src

COPY --from=build /dist /dist

RUN chmod a+x /dist/busybox.$ARCH && \
    /dist/busybox.$ARCH --help | head -n 1 > /dist/.version-busybox.$ARCH && \
    /dist/busybox.$ARCH --help && \
    BINARY=/dist/busybox.$ARCH VERSION=$busyboxversion VERSIONINFO=/dist/.version-busybox.$ARCH bbensurebuild.sh
