ARG BASEIMAGE
FROM ${BASEIMAGE}

RUN apk add --no-cache alpine-sdk linux-headers \
        build-base clang openssl-dev linux-headers \
        gcc make musl-dev ncurses-static \
        openssl-libs-static zlib-static gnupg \
        flex bison lftp file bash xz

RUN addgroup -S builduser && adduser -S builduser -G builduser -s /bin/bash && \
    mkdir /src /dist && chown builduser:builduser /src /dist

WORKDIR /src
USER builduser
SHELL [ "/bin/bash", "-c" ]
