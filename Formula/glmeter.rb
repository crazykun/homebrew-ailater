class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.12"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.12/glmeter-macos-x86_64.tar.gz"
      sha256 "0115542821e5beb8ee3ea9adeac2cac4099992f9d756c9c87ce8001925d54e2e"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.12/glmeter-macos-aarch64.tar.gz"
      sha256 "2898ec57ddb6890a9c3cf6a57b22bbebab9182a07070f7519c8832672f942c02"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.12/glmeter-linux-x86_64.tar.gz"
      sha256 "c632e3e60742c6142ee2b8042e122cd5e19d199507a6943a2e92e8dbd64fffa0"
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
