class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.0/lscreen-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "8ff2cfec19b0acbb4b44e8379d3a7b1a1051d6bb961776c7da02d1a0cd972c95"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.0/lscreen-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "8f5f163ff2ca37bd1a478a080760bf629fb6e58a59abb3a1c28c22f3002b6a18"
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
