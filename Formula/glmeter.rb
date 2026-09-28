class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.8"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.8/glmeter-macos-x86_64.tar.gz"
      sha256 "c0d086d6f73d5a6150a574d0f6d61bf2e634f594afe3c3b61a9c491d590d2aa1"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.8/glmeter-macos-aarch64.tar.gz"
      sha256 "e8e99fa15835ed176e106f4e1fcb235861c3f19fba7ce24c9ee2438dfd82a4ab"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.8/glmeter-linux-x86_64.tar.gz"
      sha256 "1a19803c537ba986f2d91bedc43e99d03456f924532373834823f7f624b4e4a3"
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
