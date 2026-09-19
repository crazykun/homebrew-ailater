cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.6"
  sha256 arm:   "3621135cae22a6c642850bbf4c8a1fa254793afc2cc1921dda6d33e9e0e6af5f",
         intel: "804453a42e9642ff333aa9e6110ca4230d1c4a922fef598d4754eebfccc96a51"

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
