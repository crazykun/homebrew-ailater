class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.11.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.3/lscreen-v0.11.3-x86_64-apple-darwin.tar.gz"
      sha256 "904c3205887b567224631e93b3e3abf54ef082ea81639a5193709c5c41b6be0b"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.3/lscreen-v0.11.3-aarch64-apple-darwin.tar.gz"
      sha256 "f69bf75c22e4375c0f7f94b26a6c77c99e4857ba469b6b4141b6240b75ca43e7"
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
