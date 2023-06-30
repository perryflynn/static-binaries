ARG BASEIMAGE
FROM ${BASEIMAGE}

RUN apk add --no-cache alpine-sdk linux-headers \
        build-base clang openssl-dev linux-headers \
        gcc make musl-dev ncurses-static \
        openssl-libs-static zlib-static gnupg \
        flex bison lftp file bash xz

WORKDIR /src
SHELL [ "/bin/bash", "-c" ]
