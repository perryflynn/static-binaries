ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG ARCH=amd64
ARG packageversion=9.1.0446
ARG packagedir=vim90
ARG PARALLEL=4
ARG CHECKSUM=445da3c193a311b53808cf9dcf1192f7c33c4d8ea68f486a68fea402b611abf2

# https://github.com/dtschan/vim-static/blob/master/build.sh

USER builduser

RUN wget https://github.com/vim/vim/archive/refs/tags/v${packageversion}.tar.gz && \
    echo "$CHECKSUM v${packageversion}.tar.gz" | sha256sum -c && \
    tar xvf v${packageversion}.tar.gz && \
    cd vim-${packageversion} && \
    mkdir -p /tmp/vim && \
    LDFLAGS="-static" ./configure --prefix=/tmp/vim/ --disable-channel --disable-gpm \
        --disable-gtktest --disable-gui --disable-netbeans --disable-nls \
        --disable-selinux --disable-smack --disable-sysmouse --disable-xsmp \
        --enable-multibyte --with-features=huge --without-x --with-tlib=ncursesw && \
    make -j${PARALLEL} && \
    make install && \
    cd .. && \
    mkdir -p vim && \
    cp -r /tmp/vim/* vim/ && \
    strip vim/bin/vim && \
    tar cvzf /dist/vim-${ARCH}.tar.gz vim

RUN vim/bin/vim --version | head -n 1 > /dist/.version-vim-${ARCH}.tar.gz && \
    vim/bin/vim --version && \
    vim/bin/vim --help
