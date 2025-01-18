# Static Binaries

A collection of statically build software tools.

Download: [https://files.serverless.industries/bin/](https://files.serverless.industries/bin/)

## Tools

Last checked for new versions: 2025-01-18

⚠ arm64v8 and arm32v7 are disabled for now because of issues with docker-multiarch-qemu stuff: `gcc: internal compiler error: Segmentation fault signal terminated program cc1` ⚠

| ✅ | Verify | Name               | Version          | Release Date             | Releases |
|----|---|--------------------|------------------|--------------------------|----------|
| ✅ | sha256+gpg | busybox | 1.37.0  | 2024-09-26 | [Releases](https://busybox.net/downloads/) |
| ✅ | sha256+gpg | curl    | 8.11.1  | 2024-12-11 | [Releases](https://curl.se/download/) |
|  | sha256+gpg | dig + nsupdate | 9.16.50 | 2024-04-17 | [Releases](https://downloads.isc.org/isc/bind9/) |
| ✅ | sha256     | htop    | 3.3.0   | 2024-01-10 | [Releases](https://github.com/htop-dev/htop/releases/) |
|  | sha256     | iperf2  | 2.2.0   | 2024-04-11 | [Releases](https://sourceforge.net/projects/iperf2/files/) |
| ✅ | sha256     | iperf3  | 3.18.0  | 2024-12-14 | [Releases](https://github.com/esnet/iperf) |
| ✅ | sha256     | jq      | 1.7.1   | 2023-12-13 | [Releases](https://github.com/jqlang/jq/releases) |
| ✅ | sha256+gpg<br>sha256 | rsync<br>xxHash    | 3.4.1<br>0.8.3   | 2025-01-15<br>2024-12-29 | [Releases](https://download.samba.org/pub/rsync/src/?C=M;O=D)<br>[Releases](https://github.com/Cyan4973/xxHash/tags) |
| ✅ | sha256+gpg | OpenSSH | 9.9p1 | 2024-09-19 | [Releases](https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable) |
| ✅ | sha256+gpg<br>sha256+gpg | tcpdump<br>libpcap | 4.99.5<br>1.10.5 | 2024-08-30<br>2024-08-30 | [Releases](https://www.tcpdump.org/release) |

### Known Issues

- arm64v8 and arm32v7 are broken and disabled and unavailable for now
- dig: [Starting from 9.18 static builds are unsupported](https://kb.isc.org/docs/changes-to-be-aware-of-when-moving-from-bind-916-to-918)
- curl: libpsl and libidn2 cannot be found in `./configure` phase, so disabled for now
- iperf2: build for 2.2.1 broken, not motivated to [add patch manually](https://sourceforge.net/p/iperf2/tickets/342/)
- rsync: There is no way to verify if the gpg key `9FEF112DCE19A0DC7E882CB81BB24997A8535F6F` is valid, just took it now from keyserver.
  Just putting it on samba.org is too hard, as it looks like. [Gentoo Devs ranted on that too](https://bugs.gentoo.org/948106).

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
