ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG ARCH=amd64
ARG packageversion=9.0
ARG packagedir=vim90
ARG PARALLEL=4

# https://github.com/dtschan/vim-static/blob/master/build.sh

USER builduser

RUN wget https://ftp.nluug.nl/pub/vim/unix/vim-${packageversion}.tar.bz2 && \
    tar xvf vim-${packageversion}.tar.bz2 && \
    cd ${packagedir} && \
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
