cask "laterterm" do
  version "0.0.1"
  # sha256 由 auto-bump 从 GitHub Release asset digest 自动维护
  sha256 "84b53cda4d39b108cbf42ceb7c9418ebdbd07cf88d301bc2a31ccf166d24c075"

  url "https://github.com/ailater/LaterTerm/releases/download/v#{version}/laterterm-v#{version}-universal2-apple-darwin.dmg"
  name "LaterTerm"
  desc "Cross-platform GPU terminal with SSH, SFTP, and file transfer"
  homepage "https://github.com/ailater/LaterTerm"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  # universal2 包含 Intel / Apple Silicon；共同基线取 Apple Silicon 的 macOS 11
  depends_on :macos

  app "LaterTerm.app"
  binary "#{appdir}/LaterTerm.app/Contents/MacOS/laterterm"

  # 当前 Release 仅 ad hoc 签名，移除隔离属性避免 Gatekeeper 拦截
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/LaterTerm.app"]
  end

  # macOS 的配置与状态均落在 Application Support；密钥仍由系统钥匙串保管
  zap trash: "~/Library/Application Support/laterterm"
end
