# Maintainer: codingbme-ux
pkgname=huaweicloudmeeting-bin
pkgver=9.12.5
pkgrel=1
pkgdesc='HuaWei Cloud Meeting, prebuilt, running on system Electron with Wayland screen sharing'
arch=('x86_64')
url='https://www.huaweicloud.com/product/meeting'
license=('LicenseRef-unknown')
provides=("${pkgname%-bin}=${pkgver}")
conflicts=("${pkgname%-bin}" 'welink' 'deepin-wine-welink')
depends=('electron39')
_repo='https://github.com/codingbme-ux/huaweicloudmeeting-aur'
options=('!strip')
source=("${pkgname}-${pkgver}-app.tar.zst::${_repo}/releases/download/v${pkgver}/${pkgname}-${pkgver}-app.tar.zst"
        'huaweicloudmeeting.sh'
        'huaweicloudmeeting.desktop')
sha256sums=('af2dfcce4f61ce70df73c048977353c847ac58c0cc8f9ad43674888f25a916c9'
            'c536218bf0f7ab7203cb2fc8e6f04e25884e989ac8fcad498afe9cd0c2931bd1'
            '64015bddefb84c438089e271cc30464d9d8f801b6c054557584fd90f8a3273d8')

package() {
    install -Dm644 "${srcdir}/app.asar" "${pkgdir}/usr/lib/${pkgname%-bin}/app.asar"
    install -Dm755 "${srcdir}/huaweicloudmeeting.sh" "${pkgdir}/usr/bin/${pkgname%-bin}"
    install -Dm644 "${srcdir}/huaweicloudmeeting.desktop" \
        "${pkgdir}/usr/share/applications/${pkgname%-bin}.desktop"

    for _size in 16 32 64 128 256 512; do
        install -Dm644 "${srcdir}/icons/${_size}x${_size}.png" \
            "${pkgdir}/usr/share/icons/hicolor/${_size}x${_size}/apps/${pkgname%-bin}.png"
    done
}
