class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.1.0"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.0/glmeter-macos-x86_64.tar.gz"
      sha256 "aecd3a0fae35e38f47d723935b0450fbcf22ced60ad1d8e6f419cf821ebabf42"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.0/glmeter-macos-aarch64.tar.gz"
      sha256 "a0e6d0f9e8d885b8916f39c7963fe0023c16dcc362716a1fad69ffb85896c385"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.0/glmeter-linux-x86_64.tar.gz"
      sha256 "a96a6a640167546257bb6c8aa708b74014f0162530d23a5542f2c960707b938c"
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
