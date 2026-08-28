class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.1"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.1/glmeter-macos-x86_64.tar.gz"
      sha256 "4da13e2d540ef7589b58616e3de12876d2579c56597f38b212c082898d613f06"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.1/glmeter-macos-aarch64.tar.gz"
      sha256 "ecc561db90afb94e60e7845a8c892fb0af1391d88434b3f8841fe3b03fd0a365"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.1/glmeter-linux-x86_64.tar.gz"
      sha256 "67307b5cedbf526ade72d608c06bafc2968f2ddbff79c4f10f796fd709ecd075"
    else
      depends_on arch: :x86_64
    end
  end

  def install
    bin.install "glmeter"
  end

  def caveats
    <<~EOS
      First run creates a config template at:
        ~/.config/glmeter/config.toml (Linux/macOS)
        %APPDATA%\\glmeter\\config.toml (Windows)
      Fill in api_key from https://open.bigmodel.cn (CN) or https://z.ai (global),
      then click "↻ 立即刷新" in the tray menu.

      Tray:  glmeter          (5h quota, reset countdown, auto-activate)
      CLI:   glmeter --check  (print quota & exit)
             glmeter --check --activate
      Docs:  https://github.com/crazykun/GLMeter
    EOS
  end
end
