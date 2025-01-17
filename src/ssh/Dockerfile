ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG sshversion=9.9p1
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=b343fbcdbff87f15b1986e6e15d6d4fc9a7d36066be6b7fb507087ba8f966c02

RUN apk add --no-cache zlib-dev zlib-static

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${sshversion}.tar.gz \
        https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${sshversion}.tar.gz.asc && \
    echo "$CHECKSUM openssh-${sshversion}.tar.gz" | sha256sum -c && \
    bbchecksig.sh "RELEASE_KEY.asc" "openssh-${sshversion}.tar.gz.asc" "openssh-${sshversion}.tar.gz" && \
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
    /dist/ssh.$ARCH -V > /dist/.version-scp.$ARCH 2>&1 && \
    /dist/ssh.$ARCH -V > /dist/.version-sftp.$ARCH 2>&1 && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh.$ARCH 2>&1 && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keygen.$ARCH 2>&1 && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keyscan.$ARCH 2>&1 && \
    /dist/ssh.$ARCH -V 2>&1
