#     _         _       ____    ____
#    / \   _ __(_) __ _|___ \  |  _ \ _ __ ___
#   / _ \ | '__| |/ _` | __) | | |_) | '__/ _ \
#  / ___ \| |  | | (_| |/ __/  |  __/| | | (_) |
# /_/   \_\_|  |_|\__,_|_____| |_|   |_|  \___/
#
# https://github.com/P3TERX/Docker-Aria2-Pro
#
# Copyright (c) 2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
INFO="[${Green_font_prefix}INFO${Font_color_suffix}]"
ERROR="[${Red_font_prefix}ERROR${Font_color_suffix}]"
WARN="[${Yellow_font_prefix}WARN${Font_color_suffix}]"
DOWNLOAD_DIR="/downloads"
ARIA2_CONF_DIR="/config"
ARIA2_CONF="${ARIA2_CONF_DIR}/aria2.conf"
SCRIPT_CONF="${ARIA2_CONF_DIR}/script.conf"
SCRIPT_DIR="${ARIA2_CONF_DIR}/script"
CURL_OPTIONS="-fsSL --connect-timeout 3 --max-time 3"
PROFILE_URL1="https://p3terx.github.io/aria2.conf"
PROFILE_URL2="https://aria2c.now.sh"
PROFILE_URL3="https://cdn.jsdelivr.net/gh/P3TERX/aria2.conf"

FILE_ALLOCATION_SET() {
    TMP_FILE="/downloads/P3TERX.COM"
    if fallocate -l 5G ${TMP_FILE}; then
        FILE_ALLOCATION=falloc
    else
        FILE_ALLOCATION=none
    fi
    rm -f ${TMP_FILE}
    sed -i "s@^\(file-allocation=\).*@\1${FILE_ALLOCATION}@" "${ARIA2_CONF}"
}

CONVERSION_ARIA2_CONF() {
    sed -i "s@^\(rpc-listen-port=\).*@\1${RPC_PORT:-6800}@" "${ARIA2_CONF}"
    sed -i "s@^\(listen-port=\).*@\1${LISTEN_PORT:-6888}@" "${ARIA2_CONF}"
    sed -i "s@^\(dht-listen-port=\).*@\1${LISTEN_PORT:-6888}@" "${ARIA2_CONF}"
    sed -i "s@^\(dir=\).*@\1/downloads@" "${ARIA2_CONF}"
    sed -i "s@/root/.aria2@${ARIA2_CONF_DIR}@" "${ARIA2_CONF}"
    sed -i "s@^#\(retry-on-.*=\).*@\1true@" "${ARIA2_CONF}"
    sed -i "s@^\(max-connection-per-server=\).*@\132@" "${ARIA2_CONF}"
    sed -i "s@^\(on-download-stop=\).*@\1${SCRIPT_DIR}/delete.sh@" ${ARIA2_CONF}
    sed -i "s@^\(on-download-complete=\).*@\1${SCRIPT_DIR}/clean.sh@" "${ARIA2_CONF}"
    [[ $TZ != "Asia/Shanghai" ]] && sed -i '11,$s/#.*//;/^$/d' "${ARIA2_CONF}"
    FILE_ALLOCATION_SET
}

CONVERSION_SCRIPT_CONF() {
    sed -i "s@\(upload-log=\).*@\1${ARIA2_CONF_DIR}/upload.log@" "${SCRIPT_CONF}"
    sed -i "s@\(move-log=\).*@\1${ARIA2_CONF_DIR}/move.log@" "${SCRIPT_CONF}"
    sed -i "s@^\(dest-dir=\).*@\1${DOWNLOAD_DIR}/completed@" "${SCRIPT_CONF}"
}

CONVERSION_CORE() {
    sed -i "s@\(ARIA2_CONF_DIR=\"\).*@\1${ARIA2_CONF_DIR}\"@" "${SCRIPT_DIR}/core"
}

DOWNLOAD_PROFILE() {
    for PROFILE in ${PROFILES}; do
        [[ ${PROFILE} = *.sh || ${PROFILE} = core ]] && cd "${SCRIPT_DIR}" || cd "${ARIA2_CONF_DIR}"
        while [[ ! -f ${PROFILE} ]]; do
            rm -rf ${PROFILE}
            echo
            echo -e "${INFO} Downloading '${PROFILE}' ..."
            curl -O ${CURL_OPTIONS} ${PROFILE_URL1}/${PROFILE} ||
                curl -O ${CURL_OPTIONS} ${PROFILE_URL2}/${PROFILE} ||
                curl -O ${CURL_OPTIONS} ${PROFILE_URL3}/${PROFILE}
            [[ -s ${PROFILE} ]] && {
                [[ "${PROFILE}" = "aria2.conf" ]] && CONVERSION_ARIA2_CONF
                [[ "${PROFILE}" = "script.conf" ]] && CONVERSION_SCRIPT_CONF
                [[ "${PROFILE}" = "core" ]] && CONVERSION_CORE
                echo
                echo -e "${INFO} '${PROFILE}' download completed !"
            } || {
                echo
                echo -e "${ERROR} '${PROFILE}' download error, retry ..."
                sleep 3
            }
        done
    done
}
