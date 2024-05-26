ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG htopversion=3.3.0
ARG ARCH=amd64
ARG PARALLEL=4

RUN apk add --no-cache ncurses-static ncurses-dev libcap-dev libcap-static lm-sensors lm-sensors-dev

USER builduser

RUN wget https://github.com/htop-dev/htop/releases/download/${htopversion}/htop-${htopversion}.tar.xz && \
    tar xvf htop-${htopversion}.tar.xz && \
    cd htop-${htopversion} && \
    ./configure --enable-static --enable-unicode --enable-affinity --enable-capabilities --enable-sensors && \
    make -j${PARALLEL} && \
    mv htop /dist/htop.$ARCH && \
    strip /dist/htop.$ARCH

RUN chmod a+x /dist/htop.$ARCH && \
    /dist/htop.$ARCH --version | head -n 1 > /dist/.version-htop.$ARCH && \
    /dist/htop.$ARCH --version && \
    /dist/htop.$ARCH --help
