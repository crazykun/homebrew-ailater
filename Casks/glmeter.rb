cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.14"
  sha256 arm:   "0ecb6e63b6c23f6b0c9ce5f8d3d0a9d4991442e41dc557a9a26f34931eae4c51",
         intel: "94467d6a416db978d130f5178dcaa9ae8916fdd3ec1c93dcccc5d773fbfe1b0b"

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
