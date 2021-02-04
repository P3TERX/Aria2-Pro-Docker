**English** | [中文](https://p3terx.com/archives/docker-aria2-pro.html)

# Aria2 Pro Docker

[![LICENSE](https://img.shields.io/github/license/P3TERX/Aria2-Pro-Docker?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Aria2-Pro-Docker/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Aria2-Pro-Docker.svg?style=flat-square&label=Stars&logo=github)](https://github.com/P3TERX/Aria2-Pro-Docker/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/Aria2-Pro-Docker.svg?style=flat-square&label=Forks&logo=github)](https://github.com/P3TERX/Aria2-Pro-Docker/fork)
[![Docker Stars](https://img.shields.io/docker/stars/p3terx/aria2-pro.svg?style=flat-square&label=Stars&logo=docker)](https://hub.docker.com/r/p3terx/aria2-pro)
[![Docker Pulls](https://img.shields.io/docker/pulls/p3terx/aria2-pro.svg?style=flat-square&label=Pulls&logo=docker&color=orange)](https://hub.docker.com/r/p3terx/aria2-pro)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/P3TERX/Aria2-Pro-Docker/Docker%20images%20build%20test?label=Actions&logo=github&style=flat-square)

A perfect Aria2 Docker image. Out of the box, just add download tasks and don't need to think about anything else.

## Features

* Supported platforms: `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6`
* Full Function: `Async DNS`, `BitTorrent`, `Firefox3 Cookie`, `GZip`, `HTTPS`, `Message Digest`, `Metalink`, `XML-RPC`, `SFTP`
* `max-connection-per-server` unlimited.
* retry on slow speed (`lowest-speed-limit`) and connection close
* High BT download rate and speed
* Get BitTorrent tracker automatically
* Download error automatically delete files
* Download cancel automatically delete files
* Automatically clear `.aria2` suffix files
* Automatically clear `.torrent` suffix files
* No lost task progress, no repeated downloads
* And more powerful features

## Usage

### Docker CLI

- No matter what architecture platform is used, just use the following command to start the container ( Just need to replace the `<TOKEN>` field ):
```
docker run -d \
    --name aria2-pro \
    --restart unless-stopped \
    --log-opt max-size=1m \
    -e PUID=$UID \
    -e PGID=$GID \
    -e UMASK_SET=022 \
    -e RPC_SECRET=<TOKEN> \
    -e RPC_PORT=6800 \
    -p 6800:6800 \
    -e LISTEN_PORT=6888 \
    -p 6888:6888 \
    -p 6888:6888/udp \
    -v $PWD/aria2-config:/config \
    -v $PWD/aria2-downloads:/downloads \
    p3terx/aria2-pro
```

- Then you need a WebUI for control, such as [AriaNg](https://github.com/mayswind/AriaNg). [This link](http://ariang.mayswind.net/latest) is provided by the developer and can be used directly. Or use Docker to deploy it yourself:
```
docker run -d \
    --name ariang \
    --log-opt max-size=1m \
    --restart unless-stopped \
    -p 6880:6880 \
    p3terx/ariang
```

> **TIPS:** It is important for the firewall to open ports.

### Docker Compose

- Download [Compose file](https://github.com/P3TERX/Aria2-Pro-Docker/blob/master/docker-compose.yml)
```
wget git.io/aria2-pro.yml
```

- Edit Compose file
```
vim aria2-pro.yml
```

- Compose up
```
docker-compose -f aria2-pro.yml up -d
```

### Other

- [Docker templates for UNRAID](https://github.com/P3TERX/unraid-docker-templates)
- [Docker Tutorial for Synology DSM (Chinese)](https://p3terx.com/archives/synology-nas-docker-advanced-tutorial-deploy-aria2-pro.html)

## Parameters

| Parameter                        | Function                                                                                                                                                                  |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e PUID=$UID`<br>`-e PGID=$GID` | Bind UID and GID to the container, which means you can use a non-root user to manage downloaded files.                                                                    |
| `-e UMASK_SET=022`               | For umask setting of Aria2, optional , default if left unset is `022`                                                                                                     |
| `-e RPC_SECRET=<TOKEN>`          | Set RPC secret authorization token. Default: `P3TERX`                                                                                                                     |
| `-e RPC_PORT=6800`               | Set RPC listen port.                                                                                                                                                      |
| `-p 6800:6800`                   | bind RPC listen port.                                                                                                                                                     |
| `-e LISTEN_PORT=6888`            | Set TCP/UDP port number for BitTorrent/DHT listen.                                                                                                                        |
| `-p 6888:6888`                   | Bind BT listen port (TCP).                                                                                                                                                |
| `-p 6888:6888/udp`               | Bind DHT lisen port (UDP).                                                                                                                                                |
| `-v <PATH>:/config`              | Contains all relevant configuration files.                                                                                                                                |
| `-v <PATH>:/downloads`           | Location of downloads on disk.                                                                                                                                            |
| `-e DISK_CACHE=<SIZE>`           | Set up disk cache. SIZE can include `K` or `M` (1K = 1024, 1M = 1024K), e.g `64M`.                                                                                        |
| `-e IPV6_MODE=<BOOLEAN>`         | Whether to enable IPv6 support for Aria2. Optional: `true` or `false`. Set the options `disable-ipv6=false` and `enable-dht6=true` in the configuration file(aria2.conf). |
| `-e UPDATE_TRACKERS=<BOOLEAN>`   | Whether to update BT Trackers List automatically. Optional: `true` or `flase`, default if left unset is `true`                                                            |
| `-e CUSTOM_TRACKER_URL=<URL>`    | Custom BT Trackers List URL. If not set, it will be get from https://trackerslist.com/all_aria2.txt.                                                                      |
| `-e TZ=Asia/Shanghai`            | Specify a timezone to use e.g. `Asia/Shanghai`                                                                                                                            |

## Advanced

I am working hard on my English, so this part may be explained in detail later. If you can read Chinese, read the details in [my blog](https://p3terx.com/archives/docker-aria2-pro.html).

## Credits

* [aria2](https://github.com/aria2/aria2)
* [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)
* [P3TERX/Aria2-Pro-Core](https://github.com/P3TERX/Aria2-Pro-Core)
* [just-containers/s6-overlay](https://github.com/just-containers/s6-overlay)
* [XIU2/TrackersListCollection](https://github.com/XIU2/TrackersListCollection)

## License

[MIT](https://github.com/P3TERX/Aria2-Pro-Docker/blob/master/LICENSE) © P3TERX
