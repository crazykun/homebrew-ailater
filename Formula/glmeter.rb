class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.13"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.13/glmeter-macos-x86_64.tar.gz"
      sha256 "0fcf7224bfb3ce63f72a821193a06346904ab510066b6b8e7040a7ea3f2ea7ff"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.13/glmeter-macos-aarch64.tar.gz"
      sha256 "2c4eb9257383efd64fd85a6a7e3f7c0cd41bc582bd00653a5d91f957c21e4dda"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.13/glmeter-linux-x86_64.tar.gz"
      sha256 "a25ae1c0daa6f8dccd34b55e7701b6e62396afe3215680933d925f2513716922"
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
