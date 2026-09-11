class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.8.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.2/lscreen-v0.8.2-x86_64-apple-darwin.tar.gz"
      sha256 "5cacb7705c5203fb2f577ac6e58c7dd4c264b8ee706375a7d9651913a47a88a7"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.2/lscreen-v0.8.2-aarch64-apple-darwin.tar.gz"
      sha256 "839ee8051c41cffff45e92b08b3ec8a5d973768237894ed86bb347f78d59968f"
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
