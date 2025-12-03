ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG sshversion=10.2p1
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=ccc42c0419937959263fa1dbd16dafc18c56b984c03562d2937ce56a60f798b2

RUN apk add --no-cache zlib-dev zlib-static

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${sshversion}.tar.gz \
        https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${sshversion}.tar.gz.asc && \
    echo -n "Checksum of downloaded file: " && sha256sum "openssh-${sshversion}.tar.gz" && \
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
    /dist/ssh.$ARCH -V 2>&1 && \
    /dist/ssh.$ARCH -V > /dist/.version-scp.$ARCH 2>&1 && \
    BINARY=/dist/scp.$ARCH VERSION=$sshversion VERSIONINFO=/dist/.version-scp.$ARCH bbensurebuild.sh && \
    /dist/ssh.$ARCH -V > /dist/.version-sftp.$ARCH 2>&1 && \
    BINARY=/dist/sftp.$ARCH VERSION=$sshversion VERSIONINFO=/dist/.version-sftp.$ARCH bbensurebuild.sh && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh.$ARCH 2>&1 && \
    BINARY=/dist/ssh.$ARCH VERSION=$sshversion VERSIONINFO=/dist/.version-ssh.$ARCH bbensurebuild.sh && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keygen.$ARCH 2>&1 && \
    BINARY=/dist/ssh-keygen.$ARCH VERSION=$sshversion VERSIONINFO=/dist/.version-ssh-keygen.$ARCH bbensurebuild.sh && \
    /dist/ssh.$ARCH -V > /dist/.version-ssh-keyscan.$ARCH 2>&1 && \
    BINARY=/dist/ssh-keyscan.$ARCH VERSION=$sshversion VERSIONINFO=/dist/.version-ssh-keyscan.$ARCH bbensurebuild.sh
