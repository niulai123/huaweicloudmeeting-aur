# Maintainer: niulai123
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
_repo='https://github.com/niulai123/huaweicloudmeeting-aur'
options=('!strip')
source=("${pkgname}-${pkgver}-app.tar.zst::${_repo}/releases/download/v${pkgver}/${pkgname}-${pkgver}-app.tar.zst"
        'huaweicloudmeeting.sh'
        'huaweicloudmeeting.desktop')
sha256sums=('4ca5487b6b57113a56f032f08fc7663cbc85949e4fa9786c4e681cc6b90f6014'
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
