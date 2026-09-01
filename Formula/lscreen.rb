class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.8.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.1/lscreen-v0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "98901103babfee7db985d589eb56317e20b0a872b18a207f2a1a4b6e0001e262"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.8.1/lscreen-v0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "c81b1c41e8796f5b77f93585bda4dbc8f257fae6d93cc1c96fcf71c3ffe66640"
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
