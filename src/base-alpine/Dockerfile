ARG BASEIMAGE
FROM ${BASEIMAGE}

RUN apk add build-base clang openssl-dev linux-headers \
        gcc make musl-dev ncurses-static \
        openssl-libs-static zlib-static gnupg \
        flex bison \
        lftp file

WORKDIR /src
SHELL [ "/bin/bash", "-c" ]
