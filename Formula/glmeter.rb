class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.6"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.6/glmeter-macos-x86_64.tar.gz"
      sha256 "a2aff8ca4802aa5b0bb944dde7b3698eaae432dcbe5de2e90f4b959a4535c683"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.6/glmeter-macos-aarch64.tar.gz"
      sha256 "b1e092466390a2f0a5f64984ee314b66c85206067efba4da8b7e5dc84998b948"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.6/glmeter-linux-x86_64.tar.gz"
      sha256 "4b37a46a1b3fbee65fa01f49bfa27560e574377061184f26f3287f13b4d1f1a4"
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
