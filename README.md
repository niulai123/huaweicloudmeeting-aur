# 华为云会议 Linux 客户端（Wayland 屏幕共享修复）

华为云会议官方没有提供 x86_64 Linux 客户端下载，AUR 上 `huaweicloudmeeting-bin`
的 9.12.5 源文件也已失效。本仓库提供可用的 9.12.5 应用包，并修复了 Wayland
会话下共享屏幕黑屏的问题。

## 问题

客户端基于 Electron 22。该版本在 GNOME/KDE Wayland 上使用 PipeWire 采集时会在
`DesktopMediaList` 线程中崩溃；退回 X11 采集则只能拿到黑帧，会议中表现为
“正在共享屏幕”但预览和远端画面全黑。

## 修复

- 应用文件取自星火玲珑商店的 9.12.5 构建（`huaweicloudmeeting.linyaps`）。
- 运行时改用仓库中的 `electron39`，其 PipeWire 采集在 Wayland 下可用。
- 启动脚本在 Wayland 会话下自动追加：
  `--enable-features=WebRTCPipeWireCapturer --ozone-platform=wayland`
- 用户可在 `~/.config/HuaWeiCloudMeeting/flags.conf` 中追加自己的 Electron 参数，
  每行一个。

## 安装

```sh
git clone https://github.com/codingbme-ux/huaweicloudmeeting-aur.git
cd huaweicloudmeeting-aur
makepkg -si
```

依赖 `electron39`（Arch 官方仓库）。安装后从应用菜单或终端执行
`huaweicloudmeeting` 启动。

## 已知限制

- 屏幕共享通过 xdg-desktop-portal 完成，首次共享时系统会弹出选择屏幕/窗口的
  对话框。
- 仅验证了 x86_64 与 GNOME Wayland；KDE 及其他桌面尚未测试。
- 应用为华为的闭源客户端，许可证状态未知，本仓库仅做打包分发。

## AUR

上游 AUR 的 `huaweicloudmeeting-bin` 由他人维护，其 9.12.5 源地址已失效。
本仓库的 PKGBUILD 使用同名 `pkgbase`，便于在原包转为 orphan 后接管；也可以
改用 `huaweicloudmeeting-wayland-bin` 作为独立包名发布。

## 构建载荷

`build-payload.sh` 可从本机玲珑安装的层目录重新生成 `app.asar` 载荷：

```sh
ll-cli install huaweicloudmeeting.linyaps
./build-payload.sh
```
