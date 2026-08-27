cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.1.1"
  sha256 arm:   "9e42776d85989bea8fdf3f88088b9a41bbf735fb1c77f34813aaeebbb863f7e9",
         intel: "1de748ac87d32aa87a0893db396cece6f1fade2463631e187970b70b892f4e77"

  url "https://github.com/crazykun/GLMeter/releases/download/v#{version}/glmeter-macos-#{arch}.dmg",
      verified: "github.com/crazykun/GLMeter/"
  name "GLMeter"
  desc "GLM Coding Plan quota tray monitor"
  homepage "https://github.com/crazykun/GLMeter"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  # 菜单栏常驻应用（无 Dock 图标）
  app "GLMeter.app"

  # 移除隔离属性，避免 macOS 提示“已损坏，无法打开”或“无法验证开发者”
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GLMeter.app"]
  end

  zap trash: "~/.config/glmeter"
end
