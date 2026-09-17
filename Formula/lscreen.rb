class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.10.1/lscreen-v0.10.1-x86_64-apple-darwin.tar.gz"
      sha256 "d9c71604596004bff6bb809d325d917c12d8eec8232a953744bc08c1d66f1640"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.10.1/lscreen-v0.10.1-aarch64-apple-darwin.tar.gz"
      sha256 "1fa73f91845daa18e4641284f45e1c855296891e2603ed4cbefeaa0c80899fcb"
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
