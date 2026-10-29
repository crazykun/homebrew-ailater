class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.14"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.14/glmeter-macos-x86_64.tar.gz"
      sha256 "92fb0bacc5b1cb3a63315f660fe907b7f2bdaf5b787cf8f81cd68e9a0a945ae9"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.14/glmeter-macos-aarch64.tar.gz"
      sha256 "94f113d95c63c7f6c2f78db60c22ab4141311e616ffdffce747e9e7d4d990ec1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.14/glmeter-linux-x86_64.tar.gz"
      sha256 "619edbef15edb68a7add8b5529a710a73e277d5948050283cabba6c95b251274"
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
