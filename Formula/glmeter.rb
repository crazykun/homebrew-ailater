class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.11"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.11/glmeter-macos-x86_64.tar.gz"
      sha256 "46cd0115921d582110d5617f528f55d1873f5afbe836e15e6b55a9c467f07518"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.11/glmeter-macos-aarch64.tar.gz"
      sha256 "93fe1ef376bd05611a583f215379adfdbab69efddcff760e5b93d9fa2333bd1d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.11/glmeter-linux-x86_64.tar.gz"
      sha256 "d040da0abca10597d45b35d1a7aee5904033bfefad0b9104b66c678e2724707a"
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
