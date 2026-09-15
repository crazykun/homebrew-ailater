class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.9.0/lscreen-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "f1e10b9cf8d3539008384c67adddd4b3a6813e7a7538bb39f36d774393dd3511"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.9.0/lscreen-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "893f45b7388f603cc2b1157c786a275ef3f5abf76546b96b01aefc518219195d"
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
