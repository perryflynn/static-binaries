#!/usr/bin/env bats

@test "ensure features" {
    /dist/rsync.$ARCH --version --version | jq -M '.capabilities.IPv6' | grep -q -Fx "true"
    /dist/rsync.$ARCH --version --version | jq -M '.capabilities.ACLs' | grep -q -Fx "true"
    /dist/rsync.$ARCH --version --version | jq -M '.capabilities.xattrs' | grep -q -Fx "true"
    /dist/rsync.$ARCH --version --version | jq -M '.capabilities.iconv' | grep -q -Fx "true"
    /dist/rsync.$ARCH --version --version | jq -M '.optimizations.openssl_crypto' | grep -q -Fx "true"
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.checksum_list | index("xxh128")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.checksum_list | index("xxh3")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.checksum_list | index("xxh64")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.compress_list | index("zstd")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.compress_list | index("lz4")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.compress_list | index("zlibx")'
    /dist/rsync.$ARCH --version --version  | jq -e -c -M '.compress_list | index("zlib")'
}
