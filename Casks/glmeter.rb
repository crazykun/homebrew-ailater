cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.15"
  sha256 arm:   "a1116154563828864ce805bdf3d824906c2ec79fab906ff17e3cd554303fcfe2",
         intel: "eb41ac19bfee23546b25b813b7b7f427909a155cb64fd3b09c2e043f6a26eb41"

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
