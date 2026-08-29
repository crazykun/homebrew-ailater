class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.2"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.2/glmeter-macos-x86_64.tar.gz"
      sha256 "3e32684a55f8676a6ae1a79be09b6d0575447ec2c1b9a2a52e1576bf6206b0e4"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.2/glmeter-macos-aarch64.tar.gz"
      sha256 "f9cf886c6d1606e5f5839fc0b51e3aba37b14ecf94e5fc14c02b49f4050cbb80"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.2/glmeter-linux-x86_64.tar.gz"
      sha256 "dac0c2fcb548310ab7e3514f19138c4dbc223344837461d6a9237861b1cceafe"
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
