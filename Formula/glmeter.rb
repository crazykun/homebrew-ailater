class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.15"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.15/glmeter-macos-x86_64.tar.gz"
      sha256 "6665b422866159daba5251ffa7dae50f0f30d8bf407cf91bdaf89f25eaa7e7c6"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.15/glmeter-macos-aarch64.tar.gz"
      sha256 "007779d010beaa3e4f4913bfaccba0118455752346d8600ddece5642e586c14a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.15/glmeter-linux-x86_64.tar.gz"
      sha256 "5cd34658aec5d554d1448f11c984e7124fa69adcb456c4ba1a1ea5f090dde910"
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
