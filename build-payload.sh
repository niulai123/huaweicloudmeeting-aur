#!/bin/bash
# Rebuild the app payload tarball from the vendor deb distributed through the
# UnionTech (UOS) app store. The store redirects to a CDN that rejects requests
# without a browser User-Agent and Referer, so curl needs both here.
set -euo pipefail

deb_url='https://pro-store-packages.uniontech.com/appstore/pool/appstore/h/huaweicloudmeeting/huaweicloudmeeting_9.12.5_amd64.deb'
deb_sha256='60e15e2a93c0529c4573a6c616e76b3e74f61f4f160e7d3279fde28993982f1f'

work=$(mktemp -d)
trap 'rm -rf "${work}"' EXIT

curl -fsSL -A 'Mozilla/5.0 (X11; Linux x86_64)' -e 'https://www.uniontech.com/' \
    -o "${work}/app.deb" "${deb_url}"
echo "${deb_sha256}  ${work}/app.deb" | sha256sum -c -

mkdir -p "${work}/root"
bsdtar -xOf "${work}/app.deb" data.tar.xz | tar -xJf - -C "${work}/root"

app_dir="${work}/root/opt/华为云会议"
install -Dm644 "${app_dir}/resources/app.asar" "${work}/payload/app.asar"

for size in 16 32 64 128 256 512; do
    icon="${work}/root/usr/share/icons/hicolor/${size}x${size}/apps/huaweicloudmeeting.png"
    install -Dm644 "${icon}" "${work}/payload/icons/${size}x${size}.png"
done

tar --zstd -C "${work}/payload" -cf huaweicloudmeeting-bin-9.12.5-app.tar.zst app.asar icons
sha256sum huaweicloudmeeting-bin-9.12.5-app.tar.zst
