cask "laterkey" do
  version "0.1.5"
  # sha256 与 GitHub Release 的 dmg digest 一致（发布时更新）
  sha256 "18648bb55e14108b3123e9ce4ef739402c600efeec8595329b76e96dedddd888"

  url "https://github.com/ailater/LaterKey/releases/download/v#{version}/laterkey-v#{version}-universal2-apple-darwin.dmg"
  name "LaterKey"
  desc "Make Windows-layout keyboards work the Windows way on macOS"
  homepage "https://github.com/ailater/LaterKey"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  # universal2 包含 Intel / Apple Silicon
  depends_on :macos

  app "LaterKey.app"
  binary "#{appdir}/LaterKey.app/Contents/MacOS/laterkey"

  # 自签名证书、未公证：移除隔离属性避免 Gatekeeper 提示「已损坏/无法验证开发者」
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/LaterKey.app"]
  end

  caveats <<~EOS
    首次使用必须授权：系统设置 ▸ 隐私与安全性 ▸ 辅助功能 ▸ 添加 LaterKey.app。
    （launchd 常驻进程不继承其他应用的授权，必须给 LaterKey.app 本身授权；
    同一证书签名的后续版本升级不用重新授权。）

    常驻运行（登录自启、崩溃自动拉起）：
      laterkey install
    或打开 LaterKey.app 后由菜单栏托盘使用。

    卸载常驻：
      laterkey uninstall
  EOS

  zap launchctl: "io.github.crazykun.laterkey",
      trash:     [
        "~/.config/laterkey",
        "~/Library/Application Support/laterkey",
        "~/Library/LaunchAgents/io.github.crazykun.laterkey.plist",
      ]
end
