ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG sshversion=9.5p1
ARG ARCH=amd64
ARG PARALLEL=4

RUN apk apk add --no-cache libssh2-dev libssh2-static

USER builduser

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${sshversion}.tar.gz && \
    tar xvzf openssh-${sshversion}.tar.gz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    autoreconf && \
    ./configure --with-cflags=-static LIBS=-lpthread --with-ldflags=-static && \
    make -j${PARALLEL} && \
    mv scp /dist/scp.$ARCH && strip /dist/scp.$ARCH && \
    mv sftp /dist/sftp.$ARCH && strip /dist/sftp.$ARCH && \
    mv ssh /dist/ssh.$ARCH && strip /dist/ssh.$ARCH && \
    mv ssh-keygen /dist/ssh-keygen.$ARCH && strip /dist/ssh-keygen.$ARCH && \
    mv ssh-keyscan /dist/ssh-keyscan.$ARCH && strip /dist/ssh-keyscan.$ARCH

RUN chmod a+x /dist/*.$ARCH && \
    /dist/ssh.$ARCH -V > /dist/.version-scp.$ARCH && \
    /dist/ssh.$ARCH -V > /dist/.version-sftp.$ARCH && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh.$ARCH && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keygen.$ARCH && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keyscan.$ARCH && \
    /dist/ssh.$ARCH -V
