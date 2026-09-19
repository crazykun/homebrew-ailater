cask "glmeter" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.4"
  sha256 arm:   "150af1ea904ef8a382cfd18348d4df74c96189169d4c601ca51fecfc9096692b",
         intel: "236b3532eec5b61f07f5a5d7eb3155197afa574fb46befe56d5ddf4c92e7dffb"

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
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GLMeter.app"]
  end

  zap trash: "~/.config/glmeter"
end
