class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.10.0/lscreen-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "0ec27c77c072cecc8cb560846a96add1c12af3028ce7f6f5febd51165f713b64"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.10.0/lscreen-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "7c97d0d559470fe655a2b1768072d31308ead1ec3c8edcffbca8356d189e6c91"
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
