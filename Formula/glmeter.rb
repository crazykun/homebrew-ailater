class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.5"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.5/glmeter-macos-x86_64.tar.gz"
      sha256 "91ddff5d5b2558512e9e05a42cbe9f9dbe98e305735b37fcaccd70b606141166"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.5/glmeter-macos-aarch64.tar.gz"
      sha256 "d137b247f3e9e2a427a10683d6bf89629a526efc0432ad9f8c590b6af0516600"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.5/glmeter-linux-x86_64.tar.gz"
      sha256 "858e5d1f6a40902379eb372ffd26c568a4f563b3d3c40a20f3d97816770263aa"
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
