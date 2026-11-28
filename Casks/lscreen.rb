cask "lscreen" do
  version "0.15.4"
  # v0.8.0 起 dmg 只出 universal2 单包（package.sh 双架构 lipo 合一），
  # 按架构拼 URL 的旧写法 404——cask 因此停在 0.6.0
  sha256 "06ca54b4ab4c3ac7e976c13574507390c96a41a18db57b8b019e17d994e3ed2d"

  url "https://github.com/crazykun/LaterScreen/releases/download/v#{version}/lscreen-v#{version}-universal2-apple-darwin.dmg"
  name "LaterScreen"
  desc "Cross-platform screenshot & annotation tool"
  homepage "https://github.com/crazykun/LaterScreen"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "LaterScreen.app"

  # v0.15.0 起自签名证书密封签名（Authority=LaterScreen），TCC 绑定证书身份，
  # 升级不再需要重新授权。首次安装或从 v0.14.3 及更早升级才需授权一次。
  caveats <<~EOS
    自 v0.15.0 起产物以自签名证书密封签名，「屏幕录制 / 麦克风」授权绑定证书身份，
    升级后无需重新授权。仅首次安装（或从 v0.14.3 及更早升级，签名身份变更）需：
    完全退出 LaterScreen → 重新打开触发一次截图 → 系统弹窗允许。
    滚动截图与裸 F 键热键另需：系统设置 ▸ 隐私与安全性 ▸ 辅助功能 添加 LaterScreen。
    macOS 15+ 会周期性弹「继续允许」确认，属系统行为，点一次即可。
  EOS

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/LaterScreen.app"]
  end

  zap trash: "~/.config/lscreen"
end
