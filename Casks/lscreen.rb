cask "lscreen" do
  version "0.11.4"
  # v0.8.0 起 dmg 只出 universal2 单包（package.sh 双架构 lipo 合一），
  # 按架构拼 URL 的旧写法 404——cask 因此停在 0.6.0
  sha256 "44f4473aba616f213f590df90258d51648624bd72851f78cf47c2f2544cd0354"

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

  # 未签名：每次升级后 macOS 视为新应用，屏幕录制/麦克风授权需重做一遍
  caveats <<~EOS
    应用未做代码签名：每次升级后 macOS 视为新应用，「屏幕录制 / 麦克风」
    授权失效会重新弹窗。处理：完全退出 LaterScreen →
    系统设置 ▸ 隐私与安全性 ▸ 屏幕录制 / 麦克风，删除旧条目 →
    重新打开触发一次截图重新授权 → 授权后再重启一次生效
    （常驻进程只在启动时读取授权）。
  EOS

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/LaterScreen.app"]
  end

  zap trash: "~/.config/lscreen"
end
