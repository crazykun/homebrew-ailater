class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.6.0/lscreen-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "f3d1e542f6fd11e5ce60752a60db1fea39bd81d0f713e9b45be3304edf95a3f5"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.6.0/lscreen-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "9d4e50ff6b8753ae28f2980154fcb1281d851051e1825e68761cb0e63d7bc713"
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
