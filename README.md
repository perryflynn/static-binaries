# Static Binaries

A collection of statically build software tools.

Download: [https://files.serverless.industries/bin/](https://files.serverless.industries/bin/)

## Tools

Last checked for new versions: 2024-05-26

| Name               | Version          | Release Date             | Releases |
|--------------------|------------------|--------------------------|----------|
| busybox            | 1.36.1           | 2023-05-18               | [Releases](https://busybox.net/downloads/) |
| curl               | 8.8.0            | 2024-05-22               | [Releases](https://curl.se/download/) |
| dig                | 9.16.50          | 2024-04-17               | [Releases](https://downloads.isc.org/isc/bind9/) |
| htop               | 3.3.0            | 2024-01-10               | [Releases](https://github.com/htop-dev/htop/releases/) |
| iperf2             | 2.2.0            | 2024-04-11               | [Releases](https://sourceforge.net/projects/iperf2/files/) |
| iperf3             | 3.17.1           | 2024-05-13               | [Releases](https://downloads.es.net/pub/iperf/) |
| jq                 | 1.7.1            | 2023-12-13               | [Releases](https://github.com/jqlang/jq/releases) |
| rsync<br>xxHash    | 3.3.0<br>0.8.2   | 2024-04-06<br>2023-07-21 | [Releases](https://download.samba.org/pub/rsync/src/?C=M;O=D)<br>[Releases](https://github.com/Cyan4973/xxHash/tags) |
| OpenSSH            | 9.7p1            | 2024-05-11               | [Releases](https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable) |
| tcpdump<br>libpcap | 4.99.4<br>1.10.4 | 2023-04-07<br>2023-04-07 | [Releases](https://www.tcpdump.org/release) |
| vim                | 9.0              | 2022-06-28               | [Releases](https://ftp.nluug.nl/pub/vim/unix/?C=M;O=D) |

### ⚠ Known Issues

- dig: [Starting from 9.18 static builds are unsupported](https://kb.isc.org/docs/changes-to-be-aware-of-when-moving-from-bind-916-to-918)

## Supported Architectures

| Architecture | Debian<br>Codename | Alpine<br>Codename | Used in                    |
|--------------|--------------------|--------------------|----------------------------|
| x86          | i386 (is i686)     | x86                | Old 32-bit PCs and Servers |
| x86_64       | amd64              | amd64              | PCs and Servers            |
| ARM32v7      | armhf              | armv7              | Raspberry Pi 2+3           |
| ARM64v8      | arm64              | aarch64            | Raspberry Pi 4             |

## Contribute

This repo is just a mirror of a private GitLab Repository.

Please create an issue if you want to contribute.
