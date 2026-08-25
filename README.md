# homebrew-ailater

个人 Homebrew tap，收录自研小工具。

| Formula | 说明 |
|---|---|
| [`lscreen`](https://github.com/crazykun/LaterScreen) | 跨平台截图标注工具：截图、标注、取色、二维码识别、OCR、录屏 |
| [`glmeter`](https://github.com/crazykun/GLMeter) | GLM Coding Plan 配额托盘监控：5 小时额度进度条、重置倒计时、一键/定时激活、`--check` 命令行模式 |

## 安装

```bash
brew tap crazykun/ailater
```

然后安装需要的工具：

```bash
brew install lscreen   # LaterScreen 截图标注
brew install glmeter   # GLMeter 配额托盘
```

或一步到位：

```bash
brew install crazykun/ailater/lscreen
brew install crazykun/ailater/glmeter
```

## lscreen 使用

- `lscreen` —— 静默驻留后台托盘（默认 F1 触发截图）
- `lscreen gui` —— 立即进入截图
- `lscreen --help` —— 全部子命令

## glmeter 使用

安装后先填 API Key：首次运行会生成配置模板 `~/.config/glmeter/config.toml`（macOS/Linux），在 [智谱开放平台](https://open.bigmodel.cn) 或 [Z.ai](https://z.ai) 生成 Key 填入 `api_key` 字段即可。

- `glmeter` —— 托盘常驻：5 小时/每周额度进度条、重置倒计时、MCP 月额度明细；菜单里可「激活额度」（发送最小请求触发 5h 窗口统计），窗口未激活与重置后会自动激活
- `glmeter --check` —— 命令行打印配额后退出，适合脚本/定时任务
- `glmeter --check --activate` —— 先激活再查询

托盘显示文字可自定义模板（如 `tray_title = "GLM {5h_left}%"`），Linux 无任何系统依赖（纯 Rust DBus 实现）。全部配置说明见 [GLMeter README](https://github.com/crazykun/GLMeter#配置)。

## 更新

发新版后本 tap 的 Formula 会同步更新：

```bash
brew update && brew upgrade
```
