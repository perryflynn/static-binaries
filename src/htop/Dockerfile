ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG htopversion=3.3.0
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=a69acf9b42ff592c4861010fce7d8006805f0d6ef0e8ee647a6ee6e59b743d5c

RUN apk add --no-cache ncurses-static ncurses-dev libcap-dev libcap-static lm-sensors lm-sensors-dev

USER builduser

RUN wget https://github.com/htop-dev/htop/releases/download/${htopversion}/htop-${htopversion}.tar.xz && \
    echo "$CHECKSUM htop-${htopversion}.tar.xz" | sha256sum -c && \
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
