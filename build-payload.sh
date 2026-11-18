#!/bin/bash
# Rebuild the app payload tarball from a local linyaps installation.
# Usage: ./build-payload.sh [path-to-linyaps-layer]
set -euo pipefail

layer=${1:-}
if [[ -z ${layer} ]]; then
    layer=$(find /var/lib/linglong/layers -maxdepth 4 -type d -name '华为云会议' | head -n1)
fi

if [[ ! -d ${layer} ]]; then
    echo "Huawei Cloud Meeting layer not found; run: ll-cli install huaweicloudmeeting.linyaps" >&2
    exit 1
fi

tmp=$(mktemp -d)
trap 'rm -rf "${tmp}"' EXIT

install -Dm644 "${layer}/resources/app.asar" "${tmp}/app.asar"
for size in 16 32 64 128 256 512; do
    icon="${layer}/../../share/icons/hicolor/${size}x${size}/apps/huaweicloudmeeting.linyaps_huaweicloudmeeting.png"
    install -Dm644 "${icon}" "${tmp}/icons/${size}x${size}.png"
done

tar --zstd -C "${tmp}" -cf "huaweicloudmeeting-bin-9.12.5-app.tar.zst" app.asar icons
sha256sum "huaweicloudmeeting-bin-9.12.5-app.tar.zst"
