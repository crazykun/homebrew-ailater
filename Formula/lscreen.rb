class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.15.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.15.1/lscreen-v0.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "ff0d170382f415407e87ee62e29288afb0c535032cc2cf17b0a02c044aff3310"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.15.1/lscreen-v0.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "25a40f330641317f02b9b1406c8eee1a5c56e2ec54e19045ae920f40cfcd1681"
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
