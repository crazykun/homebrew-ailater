class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.0/lscreen-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "83b291a5bf736759d741777730ab5bbca81914a3f7e3fe28f456d98099b728b0"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.0/lscreen-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "ff8d131d568819203494de24a2e137c03434da999a150a36d8ac731996bb4103"
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
