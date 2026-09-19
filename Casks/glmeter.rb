cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.5"
  sha256 arm:   "26ef848e57c12d9eb54c7f0764a320e66196b5298342ad40b3fee6a60926ba5b",
         intel: "0ca69d1ea951d6a51c0f7836fc5d71d78d05e1ba5368836c0216c31e680277a3"

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
