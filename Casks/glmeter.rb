cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.13"
  sha256 arm:   "b340af87fe622c6d7adaff30c5513857d7a2a421dd1cc6847eca93e1ba13c322",
         intel: "8242fca9c79b2c20ebb452fc3537863b69c0dd7c8ce82b63a088de2d8a72a87f"

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
