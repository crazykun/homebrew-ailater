cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.17"
  sha256 arm:   "c0366f9f5609fd86c89996d5e46094082fbe30ce3bd48dbc0db34619bf3c7841",
         intel: "5c656bb1a510f22254451b6cd397d593bd1583a9ef43acdac0e7603b9a2b9df2"

  url "https://github.com/crazykun/GLMeter/releases/download/v#{version}/glmeter-macos-#{arch}.dmg"
  name "GLMeter"
  desc "GLM Coding Plan quota tray monitor"
  homepage "https://github.com/crazykun/GLMeter"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :big_sur

  # 菜单栏常驻应用（无 Dock 图标）
  app "GLMeter.app"

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/GLMeter.app"]
  end

  zap trash: "~/.config/glmeter"
end
