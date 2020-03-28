#=================================================
#     _         _       ____    ____
#    / \   _ __(_) __ _|___ \  |  _ \ _ __ ___
#   / _ \ | '__| |/ _` | __) | | |_) | '__/ _ \
#  / ___ \| |  | | (_| |/ __/  |  __/| | | (_) |
# /_/   \_\_|  |_|\__,_|_____| |_|   |_|  \___/
#
# https://github.com/P3TERX/docker-aria2-pro
# Description: A perfect Aria2 Docker image
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com (chinese)
#=================================================
FROM p3terx/s6-alpine

LABEL maintainer P3TERX

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    RCLONE_CONFIG=/config/rclone.conf

RUN apk add --no-cache findutils dpkg && \
    curl -fsSL git.io/aria2c.sh | bash && \
    apk del --purge dpkg && \
    mkdir -p /config /downloads && \
    rm -rf /var/cache/apk/* /tmp/*

COPY root /
