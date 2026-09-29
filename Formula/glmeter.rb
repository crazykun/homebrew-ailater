class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.9"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.9/glmeter-macos-x86_64.tar.gz"
      sha256 "a898fccc66cf5406c88a95efddf8ec7f17aeb818338e10e5ea008878a6578a29"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.9/glmeter-macos-aarch64.tar.gz"
      sha256 "bfb211f61cea7ba485303fba30ea1f44e91da74d73eebe96b1ced091a932e894"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.9/glmeter-linux-x86_64.tar.gz"
      sha256 "a3bddf9446b0f8441668414cb9277318d70ffeec3b26f3092083cea0209f1107"
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
