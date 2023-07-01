ARG BASEIMAGE
FROM ${BASEIMAGE}

RUN apk add --no-cache alpine-sdk linux-headers \
        build-base clang openssl-dev linux-headers \
        gcc make musl-dev ncurses-static \
        openssl-libs-static zlib-static gnupg \
        flex bison lftp file bash xz

RUN mkdir /src /dist && chown guest:users /src /dist

WORKDIR /src
USER guest
SHELL [ "/bin/bash", "-c" ]
