#!/bin/bash
set -o pipefail

_APPDIR="/usr/lib/huaweicloudmeeting"
_CFGDIR="${XDG_CONFIG_HOME:-$HOME/.config}/HuaWeiCloudMeeting"
_FLAGS_FILE="${_CFGDIR}/flags.conf"

_DEFAULT_FLAGS=(--enable-features=WebRTCPipeWireCapturer)
if [[ ${XDG_SESSION_TYPE} == "wayland" ]]; then
    _DEFAULT_FLAGS+=(--ozone-platform=wayland)
fi

_USER_FLAGS=()
if [[ -r ${_FLAGS_FILE} ]]; then
    while IFS= read -r line; do
        [[ -z ${line} || ${line} == \#* ]] && continue
        _USER_FLAGS+=("${line}")
    done <"${_FLAGS_FILE}"
fi

export ELECTRON_IS_DEV=0
export ELECTRON_FORCE_IS_PACKAGED=true
export NODE_ENV=production

cd "${_APPDIR}" || exit 1
exec electron39 "${_APPDIR}/app.asar" "${_DEFAULT_FLAGS[@]}" "${_USER_FLAGS[@]}" "$@"
