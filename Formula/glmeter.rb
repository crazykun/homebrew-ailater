class Glmeter < Formula
  desc "GLM Coding Plan quota tray monitor: 5h window, reset countdown, one-click activation"
  homepage "https://github.com/crazykun/GLMeter"
  version "0.1.1"
  license "MIT"

  livecheck do
    url "https://github.com/crazykun/GLMeter/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.1/glmeter-macos-x86_64.tar.gz"
      sha256 "44084ed22740aac915bfdc7abb4e23cbee831768f2eea5040157ba77ad3c0279"
    else
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.1/glmeter-macos-aarch64.tar.gz"
      sha256 "ee173f9f8cff7fd9a5f1d1d275b414b8706a981dd85806c95cb224a4a3a39425"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/GLMeter/releases/download/v0.1.1/glmeter-linux-x86_64.tar.gz"
      sha256 "8c2d0823936240b9cf95574e23fd14576577f5134c2505c466b36c5841cb622b"
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
