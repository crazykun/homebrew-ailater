class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.7.0/lscreen-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "8a5dbd06857b737a592132b924d3fd5a256f5e18de4e2da3a2ac35f2ce8a7665"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.7.0/lscreen-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "b0be2b1b312977fcc92ee01f2eaf70789a0fd04473450d492916da05e6026b2b"
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
