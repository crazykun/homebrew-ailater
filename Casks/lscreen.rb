cask "lscreen" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.0"
  sha256 arm:   "24e4d27003bfd018e4f92ec6c586aa71abaf2da5dd809d4b7c72903ef3224fc3",
         intel: "8e039f51e0f71d1666050a5751bb3c36390c59d66ead0f1a38ef350ab70e667b"

  url "https://github.com/crazykun/LaterScreen/releases/download/v#{version}/lscreen-v#{version}-#{arch}-apple-darwin.dmg",
      verified: "github.com/crazykun/LaterScreen/"
  name "LaterScreen"
  desc "Cross-platform screenshot & annotation tool"
  homepage "https://github.com/crazykun/LaterScreen"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "LaterScreen.app"

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/LaterScreen.app"]
  end

  zap trash: "~/.config/lscreen"
end
