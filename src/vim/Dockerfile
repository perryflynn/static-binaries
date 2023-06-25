ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64
ARG packageversion=9.0
ARG packagedir=vim90

RUN apk add gcc make musl-dev ncurses-static && \
    wget https://ftp.nluug.nl/pub/vim/unix/vim-${packageversion}.tar.bz2 && \
    tar xvf vim-${packageversion}.tar.bz2 && \
    cd ${packagedir} && \
    LDFLAGS="-static" ./configure --disable-channel --disable-gpm \
        --disable-gtktest --disable-gui --disable-netbeans --disable-nls \
        --disable-selinux --disable-smack --disable-sysmouse --disable-xsmp \
        --enable-multibyte --with-features=huge --without-x --with-tlib=ncursesw && \
    make && \
    make install && \
    mkdir -p /dist && \
    cp -r /usr/local/* /dist && \
    ls -lisah /dist && \
    strip /dist/vim
