class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.17"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.17/glmeter-macos-x86_64.tar.gz"
      sha256 "3d7bd8526c518a1e8e52009e3c55fd7752e94ee6dac784fdaf60acd9a08ff6d9"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.17/glmeter-macos-aarch64.tar.gz"
      sha256 "a2b975592950f5a544d142c40b94ed803d2542d599e24fa0ed98df3cf9dc5645"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.17/glmeter-linux-x86_64.tar.gz"
      sha256 "d2e201da6a98b9f6edd5e8ea28e3d8ffd473f52313b738107dd3e134e54a6e21"
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
