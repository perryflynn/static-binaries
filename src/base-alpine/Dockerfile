ARG BASEIMAGE=alpine:3
FROM ${BASEIMAGE}

ARG USERID=1000
ARG USERNAME=builduser

RUN apk add --no-cache alpine-sdk linux-headers \
        build-base clang openssl-dev linux-headers \
        gcc make musl-dev ncurses-static \
        openssl-libs-static zlib-static gnupg \
        flex bison lftp file bash xz autoconf automake tini patch

COPY /root /

RUN addgroup -g ${USERID} -S ${USERNAME} && \
    adduser -u ${USERID} -S ${USERNAME} -G ${USERNAME} -s /bin/bash && \
    mkdir /src /dist && chown ${USERNAME}:${USERNAME} /src /dist && \
    echo -n "${USERID}" > /.userid && \
    echo -n "${USERNAME}}" > /.username

WORKDIR /src
ENTRYPOINT [ "/sbin/tini", "--" ]
SHELL [ "/bin/bash", "-c" ]
