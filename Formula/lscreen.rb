class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.11.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.1/lscreen-v0.11.1-x86_64-apple-darwin.tar.gz"
      sha256 "a1aa6e131438044b5f4bd3a8274bbdebf702a72b8e9c889c3fcf30dba9486f79"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.1/lscreen-v0.11.1-aarch64-apple-darwin.tar.gz"
      sha256 "02a946f9c5e3ff3e3a7ddb4cc49e34ea7a9e8843647c17e7eb503126109abe8b"
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
