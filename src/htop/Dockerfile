ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG htopversion=3.4.1
ARG CHECKSUM=904f7d4580fc11cffc7e0f06895a4789e0c1c054435752c151e812fead9f6220

# -> Build

FROM ${BASEIMAGE} AS build
ARG htopversion CHECKSUM ARCH PARALLEL

RUN apk add --no-cache ncurses-static ncurses-dev libcap-dev libcap-static lm-sensors lm-sensors-dev

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://github.com/htop-dev/htop/releases/download/${htopversion}/htop-${htopversion}.tar.xz /download/htop-${htopversion}.tar.xz && \
    echo -n "Checksum of downloaded file: " && sha256sum "/download/htop-${htopversion}.tar.xz" && \
    echo "$CHECKSUM /download/htop-${htopversion}.tar.xz" | sha256sum -c && \
    tar xf /download/htop-${htopversion}.tar.xz && \
    cd htop-${htopversion} && \
    ./configure --enable-static --enable-unicode --enable-affinity --enable-capabilities --enable-sensors && \
    make -j${PARALLEL} && \
    mv htop /dist/htop.$ARCH && \
    bbstrip.sh /dist/htop.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH htopversion

COPY --from=build /dist /dist

RUN chmod a+x /dist/htop.$ARCH && \
    /dist/htop.$ARCH --version | head -n 1 > /dist/.version-htop.$ARCH && \
    /dist/htop.$ARCH --version && \
    /dist/htop.$ARCH --help && \
    BINARY=/dist/htop.$ARCH VERSION=$htopversion VERSIONINFO=/dist/.version-htop.$ARCH bbensurebuild.sh
