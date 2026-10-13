class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.11.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.4/lscreen-v0.11.4-x86_64-apple-darwin.tar.gz"
      sha256 "c6d22e137c97e6901be538bc5fef54953d4ae6a85f16388c321ea3ba5f0af168"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.11.4/lscreen-v0.11.4-aarch64-apple-darwin.tar.gz"
      sha256 "4258170104d88955a33f220279545959a63a4bfb5064071bad6215cebb85358c"
    end
  end

  def install
    bin.install "lscreen"
  end

  def caveats
    <<~EOS
      Run `lscreen` to stay in tray, `lscreen gui` to take a screenshot now.
      Docs: https://github.com/crazykun/LaterScreen

      二进制未做代码签名：每次 `brew upgrade` 后 macOS 视为新应用，
      「屏幕录制 / 麦克风」授权失效会重新弹窗。处理：完全退出 lscreen →
      系统设置 ▸ 隐私与安全性 ▸ 屏幕录制 / 麦克风，删除旧条目 →
      重启 lscreen 触发一次截图重新授权 → 授权后再重启一次 lscreen 生效
      （常驻进程只在启动时读取授权）。
    EOS
  end

  livecheck do
    url "https://github.com/crazykun/LaterScreen/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end
end
