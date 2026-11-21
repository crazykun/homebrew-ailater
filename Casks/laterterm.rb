cask "laterterm" do
  version "0.4.0"
  # sha256 由 auto-bump 从 GitHub Release asset digest 自动维护
  sha256 "cb31dd29c51e52da97cc76abcc221989b01fe26fff30b15e00b9afeaac2e904a"

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
