class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.2.3"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.3/glmeter-macos-x86_64.tar.gz"
      sha256 "ed3384b4753e5cdbb1992ade2340fba5b274e05f3d20641c489b01f8619fdf17"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.3/glmeter-macos-aarch64.tar.gz"
      sha256 "594a40f56d66049875bb52d6cc8367f249919fbdb6e73dfcc261ece5797fcb83"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.2.3/glmeter-linux-x86_64.tar.gz"
      sha256 "ef92626a9affd60541679e323581fac421bbaaf8802831b48acd7eeb9af0e9bd"
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
