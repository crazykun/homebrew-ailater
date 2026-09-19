class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.0/lscreen-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "90b3f9a7b10a779251610289a64f01703c798e0310081742c0ad00356fa7b2e5"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.0/lscreen-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "f64066fc8546fc5e749546f66a482c5759a16f507880b830030d338c2c5aab97"
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
