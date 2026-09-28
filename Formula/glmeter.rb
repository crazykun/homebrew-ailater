class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.7"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.7/glmeter-macos-x86_64.tar.gz"
      sha256 "e6bb0bed01ba9494d6404f269b9cdea5067897f128bbef3672fb6fd7833ef1c7"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.7/glmeter-macos-aarch64.tar.gz"
      sha256 "b55aef3888e74ac73c708dc371c1fcffe51d12e290be92068e12b70a25d4920b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.7/glmeter-linux-x86_64.tar.gz"
      sha256 "48c4c4bff7bab22287b8abd330c5e089ebf3d10b5a1ba890e3f8ff9dbaf7ef35"
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
