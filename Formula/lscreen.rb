class Lscreen < Formula
  desc "Cross-platform screenshot & annotation tool (LaterScreen)"
  homepage "https://github.com/crazykun/LaterScreen"
  version "0.15.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.15.3/lscreen-v0.15.3-x86_64-apple-darwin.tar.gz"
      sha256 "9d2a3581899d270b2e5ae9680638db1739cea0174510639fc81704c8dcf1abd6"
    else
      url "https://github.com/crazykun/LaterScreen/releases/download/v0.15.3/lscreen-v0.15.3-aarch64-apple-darwin.tar.gz"
      sha256 "ff067fdd10c49387c1eb85b171de9403c2d4731a2cb113dff59a66c3bcd8040e"
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
