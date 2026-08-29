class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.7.1/lscreen-v0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "3e123d53178ddf9c61d5121cd4df9344630af3116504a4fa3aa5ce0eb5b8be94"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.7.1/lscreen-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "b331f05d50a67adbf3803d6f9d4736a3bf51bbb8ae56ab47d5b292ebe74648a5"
    end
  end

  def install
    bin.install "lscreen"
  end

  def caveats
    <<~EOS
      Run `lscreen` to stay in tray, `lscreen gui` to take a screenshot now.
      Docs: https://github.com/crazykun/LaterScreen
    EOS
  end

  livecheck do
    url "https://github.com/crazykun/LaterScreen/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end
end
