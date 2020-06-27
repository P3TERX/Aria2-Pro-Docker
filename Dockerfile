#     _         _       ____    ____
#    / \   _ __(_) __ _|___ \  |  _ \ _ __ ___
#   / _ \ | '__| |/ _` | __) | | |_) | '__/ _ \
#  / ___ \| |  | | (_| |/ __/  |  __/| | | (_) |
# /_/   \_\_|  |_|\__,_|_____| |_|   |_|  \___/
#
# https://github.com/P3TERX/docker-aria2-pro
#
# Copyright (c) 2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

FROM p3terx/s6-alpine

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    RCLONE_CONFIG=/config/rclone.conf

RUN apk add --no-cache findutils dpkg && \
    curl -fsSL git.io/aria2c.sh | bash && \
    apk del --purge dpkg && \
    mkdir -p /config /downloads && \
    rm -rf /var/cache/apk/* /tmp/*

COPY rootfs /
