# homebrew-ailater

个人 Homebrew tap，收录自研小工具。一个 `brew tap` 装齐。

| 工具 | 说明 | 提供形式 | 系统要求 |
|---|---|---|---|
| [**LaterKey**](https://github.com/ailater/LaterKey) | 让 Windows 布局键盘在 Mac 上按 Windows 习惯工作：Ctrl+C/V 复制粘贴、Alt+Tab 切应用、Win+L 锁屏、Win+V 剪贴板历史、Ctrl+点击跳定义、Dock 再点最小化 | Cask | macOS（universal2，Intel / Apple Silicon 通吃） |
| [**LaterScreen**](https://github.com/crazykun/LaterScreen) | 跨平台截图标注：截图、标注、取色、二维码识别、OCR、录屏 | Cask / Formula | macOS 11+ |
| [**GLMeter**](https://github.com/crazykun/GLMeter) | GLM Coding Plan 配额托盘监控：5 小时额度进度条、重置倒计时、一键/定时激活、`--check` 命令行模式 | Cask / Formula | macOS 11+ / Linux（Formula） |
| [**LaterMD**](https://github.com/ailater/LaterMd) | Markdown 知识工作台：双栏实时预览、多标签、文件树、大纲、全文搜索、AI 流式写作、Git 只读集成、MCP 服务器 | Cask | macOS 14+ |
| [**LaterTerm**](https://github.com/ailater/LaterTerm) | 跨平台 GPU 终端：多标签、分屏、SSH / SFTP、ZMODEM / trzsz 文件传输、主题与设置热加载 | Cask | macOS（universal2） |

## 安装

```bash
brew tap crazykun/ailater
```

安装单个工具：

```bash
# Cask：装 .app 到 /Applications（推荐，托盘类工具的常规形态）
brew install --cask crazykun/ailater/laterkey
brew install --cask crazykun/ailater/lscreen
brew install --cask crazykun/ailater/glmeter
brew install --cask crazykun/ailater/latermd
brew install --cask crazykun/ailater/laterterm

# Formula：仅命令行二进制（脚本 / 无 GUI 场景，只有 lscreen 与 glmeter 提供）
brew install crazykun/ailater/lscreen
brew install crazykun/ailater/glmeter
```

> 同一工具的 Formula 和 Cask 是两个独立包，**不要同时安装**——版本可能不同步，托盘类工具还会双开混淆。

## 各工具说明

### LaterKey

核心是**修饰键按角色分流**，不是简单对调：图形界面里物理 Ctrl 当作 Command（Ctrl+C/V/X/A/Z 复制粘贴等），终端里物理 Win 当作 Control（Win+C 中断、Win+D 结束输入）。两套习惯同时成立，不用判断当前在哪个应用。

其他 Windows 习惯：

- **Alt+Tab** 切应用、**Win+L** 锁屏、**Win+V** 剪贴板历史（文本图片都收，选中即贴回）
- **Ctrl+←/→** 按词移动光标、**Ctrl+Backspace** 按词删除
- **Ctrl+鼠标点击**：编辑器跳定义、浏览器新标签打开、访达多选
- 访达 **F2** 重命名、浏览器 **F5** 刷新；再点一次前台 App 的 Dock 图标最小化窗口

每项都能在设置面板里单独开关、立即生效；**开机自启在面板「关于」里勾选「登录时自动启动」**，也可命令行 `laterkey install` / `laterkey uninstall`。

首次使用需授权：系统设置 ▸ 隐私与安全性 ▸ 辅助功能 ▸ 添加 LaterKey.app。同一个自签名证书签名的后续版本升级不用重新授权。

### LaterScreen

- `lscreen` —— 静默驻留后台托盘（默认 F1 触发截图）
- `lscreen gui` —— 立即进入截图
- `lscreen --help` —— 全部子命令

Cask 自 v0.15.0 起用自签名证书密封签名，「屏幕录制 / 麦克风」授权绑定证书身份，升级无需重新授权；仅首次安装（或从 v0.14.3 及更早升级）需完全退出后重新打开、触发一次截图并允许。滚动截图与裸 F 键热键另需在「辅助功能」里添加 LaterScreen。macOS 15+ 会周期性弹「继续允许」确认，属系统行为。

Formula 版二进制未签名，`brew upgrade` 后授权会失效，需删掉旧条目重新授权一次。

### GLMeter

首次运行生成配置模板 `~/.config/glmeter/config.toml`，在 [智谱开放平台](https://open.bigmodel.cn) 或 [Z.ai](https://z.ai) 生成 Key 填入 `api_key` 字段即可。

- `glmeter` —— 托盘常驻：5 小时/每周额度进度条、重置倒计时、MCP 月额度明细；菜单里可「激活额度」，窗口未激活与重置后会自动激活
- `glmeter --check` —— 命令行打印配额后退出，适合脚本/定时任务
- `glmeter --check --activate` —— 先激活再查询

托盘显示文字可自定义模板（如 `tray_title = "GLM {5h_left}%"`）。Linux 无任何系统依赖（纯 Rust DBus 实现）。全部配置说明见 [GLMeter README](https://github.com/crazykun/GLMeter#配置)。

### LaterMD

- `latermd` —— 打开主窗口：左侧文件树 / 大纲 / 搜索，中间源码编辑，右侧实时预览
- 支持 `[[wikilink]]` 双向链接、HTML 导出、Git 只读状态/历史/diff/blame
- 设置里可配 AI API key（未配时走 Mock 演示）、主题/皮肤/密度、快捷键、MCP 服务器（默认关闭，仅绑 127.0.0.1）
- `latermd 文档.md` 可从终端直开文档（cask 已建命令行软链）

### LaterTerm

- `laterterm` —— 从终端启动；也可从 Launchpad 或 `/Applications/LaterTerm.app` 打开
- 配置与主题位于 `~/Library/Application Support/laterterm`；TOTP / SSH 等密钥保存在 macOS 钥匙串，不写入配置文件

## 更新

各工具的 Formula / Cask 由本仓库的 auto-bump 工作流每小时（`:23`）自动同步 GitHub 最新 Release，版本与 sha256 不用手动改。升级：

```bash
brew update && brew upgrade
```

只想升某个 Cask：

```bash
brew upgrade --cask crazykun/ailater/laterkey
```

## 卸载

```bash
brew uninstall --cask crazykun/ailater/laterkey
brew uninstall crazykun/ailater/glmeter
```

带 `--zap` 可一并删掉配置文件（各 cask 的 `zap` 块已声明清理路径，LaterKey 还含 LaunchAgent）：

```bash
brew uninstall --zap --cask crazykun/ailater/laterkey
```

## 维护

- `Casks/`、`Formula/` 下的版本与 sha256 由 `.github/workflows/auto-bump.yml` 自动维护，脚本在 `.github/scripts/`；
- 新增工具时确保 Release 资产命名带固定版本号（如 `工具名-v{version}-universal2-apple-darwin.dmg`），`livecheck` 才能自动发现新版本；
- 自签名证书、未公证的 App 需在 cask 里用 `postflight` / `postflight_steps` 移除 `com.apple.quarantine`，否则 Gatekeeper 会报「已损坏，无法验证开发者」。
