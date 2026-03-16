# codex-skills

这个仓库是当前用户 Codex 全局 skills 的 git 管理事实来源。

## 管理范围

本仓库只管理可复用的 skill 内容：

- `skills/` -> 同步到 `C:\Users\Administrator\.codex\skills`
- `superpowers/` -> 同步到 `C:\Users\Administrator\.codex\superpowers`

它不管理以下机器本地状态：

- `C:\Users\Administrator\.codex\config.toml`
- `C:\Users\Administrator\.codex\auth.json`
- `C:\Users\Administrator\.codex\sqlite\`
- `C:\Users\Administrator\.codex\sessions\`
- 其他缓存、日志和密钥文件

## 目录结构

- `skills/.system/`：当前系统 skills 的镜像快照
- `skills/app-pre-dev-sync/`：全局 app 开发前同步 skill
- `skills/app-worklog-pulse/`：全局 app 开发中途留痕 skill
- `skills/app-post-dev-sync/`：全局 app 开发后回写 skill
- `superpowers/skills/`：当前 superpowers skills 的镜像快照
- `scripts/install-global-skills.ps1`：把本仓库安装到本机 Codex 目录
- `docs/design/`：记录迁移和结构决策

## 安装

```powershell
Set-Location E:\codex-skills
.\scripts\install-global-skills.ps1
```

如果你希望目标 skill 目录与本仓库完全一致，使用 `-Mirror`：

```powershell
Set-Location E:\codex-skills
.\scripts\install-global-skills.ps1 -Mirror
```

## 跨机器同步

1. 在目标机器上 clone 本仓库。
2. 拉取最新变更。
3. 运行 `.\scripts\install-global-skills.ps1`。
4. 重新打开一个新的 Codex session，让更新后的全局 skills 被重新发现。
