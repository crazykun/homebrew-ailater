cask "lscreen" do
  version "0.11.0"
  # v0.8.0 起 dmg 只出 universal2 单包（package.sh 双架构 lipo 合一），
  # 按架构拼 URL 的旧写法 404——cask 因此停在 0.6.0
  sha256 "2c934acde70608682db4c4cec5be9fd14c37ec29bdfbcf1376554253d0c54ba5"

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

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/LaterScreen.app"]
  end

  zap trash: "~/.config/lscreen"
end
