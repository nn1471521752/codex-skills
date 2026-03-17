# codex-skills

这个仓库是当前用户全局 `Codex` 配套能力的 git 源仓库。

## 管理范围

本仓库管理 3 类全局文件：

- `AGENTS.md` -> 安装到 `%USERPROFILE%\.codex\AGENTS.md`
- `skills/` -> 安装到 `%USERPROFILE%\.codex\skills`
- `superpowers/` -> 安装到 `%USERPROFILE%\.codex\superpowers`

不纳入这个仓库的内容包括：

- `%USERPROFILE%\.codex\config.toml`
- `%USERPROFILE%\.codex\auth.json`
- `%USERPROFILE%\.codex\sqlite\`
- `%USERPROFILE%\.codex\sessions\`
- 其他日志、缓存、状态库和密钥文件

## 当前约定

- 这里的 `skills/`、`superpowers/`、`AGENTS.md` 是长期维护的事实来源。
- 安装目录 `%USERPROFILE%\.codex\...` 只是运行时落点，不应当作为主要手改来源。
- `superpowers/` 在本仓库里按 vendor snapshot 管理；安装脚本会显式排除 `.git` 元数据，不再把仓库元信息复制到运行目录。
- 除非用户明确指定其他语言，生成或导出的 `doc` 文件默认使用中文内容与中文标题。

## 目录说明

- `AGENTS.md`：全局工作约束，包括 UTF-8、输出语言和安装关系
- `skills/.system/`：当前系统级 skills 的镜像快照
- `skills/app-pre-dev-sync/`：全局 app 开发前同步 skill
- `skills/app-worklog-pulse/`：全局 app 开发中里程碑记录 skill
- `skills/app-post-dev-sync/`：全局 app 开发后回写 skill
- `superpowers/skills/`：当前 superpowers skills 的镜像快照
- `scripts/install-global-skills.ps1`：把本仓库同步到当前用户的 `%USERPROFILE%\.codex`
- `docs/design/`：记录仓库结构和迁移设计

## 安装

```powershell
Set-Location <你的仓库路径>
.\scripts\install-global-skills.ps1
```

如果你希望目标目录和仓库内容完全对齐，可以使用：

```powershell
Set-Location <你的仓库路径>
.\scripts\install-global-skills.ps1 -Mirror
```

## 跨机器同步

1. 在目标机器上 clone 这个仓库。
2. 拉取最新变更。
3. 运行 `.\scripts\install-global-skills.ps1`。
4. 重新打开一个新的 `Codex` session，让新的全局 skills 和 `AGENTS.md` 生效。
