# Aria2 Pro

[![LICENSE](https://img.shields.io/github/license/P3TERX/docker-aria2-pro?style=flat-square&label=LICENSE)](https://github.com/P3TERX/docker-aria2-pro/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/docker-aria2-pro.svg?style=flat-square&label=Stars&logo=github)](https://github.com/P3TERX/docker-aria2-pro/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/P3TERX/docker-aria2-pro.svg?style=flat-square&label=Forks&logo=github)](https://github.com/P3TERX/docker-aria2-pro/fork)
[![Docker Stars](https://img.shields.io/docker/stars/p3terx/aria2-pro.svg?style=flat-square&label=Stars&logo=docker)](https://hub.docker.com/r/p3terx/aria2-pro)
[![Docker Pulls](https://img.shields.io/docker/pulls/p3terx/aria2-pro.svg?style=flat-square&label=Pulls&logo=docker&color=orange)](https://hub.docker.com/r/p3terx/aria2-pro)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/P3TERX/docker-aria2-pro/Docker%20images%20build%20test?label=Actions&logo=github&style=flat-square)

A perfect Aria2 Docker image.

[Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/docker-aria2-pro.html)

## Features

* Supported platforms: `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6`
* Full Function: `Async DNS`, `BitTorrent`, `Firefox3 Cookie`, `GZip`, `HTTPS`, `Message Digest`, `Metalink`, `XML-RPC`, `SFTP`
* High BT download rate and speed.
* Get BitTorrent tracker automatically.
* Download error or cancel download automatically delete files to prevent disk space consumption.
* Automatically clear `.aria2` suffix files.
* No lost task progress, no repeated downloads.

## Usage

- No matter what architecture platform is used, just use the following command to start the container ( Just need to replace the `<TOKEN>` field ):
```
docker run -d \
    --name aria2-pro \
    --restart unless-stopped \
    --log-opt max-size=1m \
    -e PUID=$UID \
    -e PGID=$GID \
    -e RPC_SECRET=<TOKEN> \
    -p 6800:6800 \
    -p 6888:6888 \
    -p 6888:6888/udp \
    -v ~/aria2-config:/config \
    -v ~/downloads:/downloads \
    p3terx/aria2-pro
```

- Then you need a WebUI for control, such as [AriaNg](https://github.com/mayswind/AriaNg). This link is provided by the developer and can be used directly: http://ariang.mayswind.net/latest

> **TIPS:** It is important for the firewall to open ports.

## Parameters

| Parameter | Function |
| --- | --- |
| `-e PUID=$UID`<br>`-e PGID=$GID` | Bind UID and GID to the container, which means you can use a non-root user to manage downloaded files. |
| `-e RPC_SECRET=<TOKEN>` | Set RPC secret authorization token. Ignoring it can be set in the configuration file. |
| `-e TZ=Asia/Shanghai` | Specify a timezone to use e.g. `Asia/Shanghai` |
| `-p 6800:6800` | RPC listen port |
| `-p 6888:6888` | BT listen port (TCP)|
| `-p 6888:6888/udp` | DHT lisen port (UDP) |
| `-v ~/aria2-config:/config` | Contains all relevant configuration files. |
| `-v ~/downloads:/downloads` | Location of downloads on disk. |
| `-e TRACKERS=no` | Disable BT tracker update, use this parameter if you need PT download. |
| `-e DISK_CACHE=<SIZE>` | Set up disk cache. SIZE can include `K` or `M` (1K = 1024, 1M = 1024K), e.g `64M`. Ignoring it can be set in the configuration file. |

## Advanced

I am working hard on my English, so this part may be explained in detail later. If you can read Chinese, read the details in [my blog](https://p3terx.com/archives/docker-aria2-pro.html).

## Credits

* [aria2](https://github.com/aria2/aria2)
* [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)
* [P3TERX/aria2-builder](https://github.com/P3TERX/aria2-builder)
* [just-containers/s6-overlay](https://github.com/just-containers/s6-overlay)
* [XIU2/TrackersListCollection](https://github.com/XIU2/TrackersListCollection)

## License

[MIT](https://github.com/P3TERX/docker-aria2-pro/blob/master/LICENSE) © P3TERX
