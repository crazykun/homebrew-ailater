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
      sha256 "b2a4f6b0da193fe3036de8ed8299a740a02049071ba999faf968f6acf2168001"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.0/glmeter-macos-aarch64.tar.gz"
      sha256 "9be2b437af05b3ae915fc6acbc30bef776bcee564d531355e5b3a2f42f8e79d4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.0/glmeter-linux-x86_64.tar.gz"
      sha256 "89a285a2687bad6fea5ca7011b3c3bd6ddec3dccf9c1bc7a5711e81f70b314b5"
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
