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

## 当前 active global 技能边界

- 当前全局 active app skills 只有 3 个：`app-pre-dev-sync`、`app-worklog-pulse`、`app-post-dev-sync`。
- 它们负责应用开发的默认闭环：开始开发前同步、开发中明确节点记录、开发后回写到 Obsidian。
- 各 app 仓库自己的 `AGENTS.md` 负责提供 Obsidian 页面路径、工作日切换规则和同步边界；这些仓库不再需要各自维护一套同职责的 active skills。
- `app-pre-dev-sync` 现在同时承担“每日计划门禁”：如果从任意 app 仓库开工时发现当前工作日 Daily 尚未形成当天计划，就先补建/补齐 Daily 里的当日计划，再继续 app 级同步。
- Obsidian Vault 专属节奏和内容流程（如 `daily-planner`、`daily-close`、`demo-to-video`、`script-draft`）本轮仍留在对应 Vault 仓库，不在这个全局仓库统一维护；其中 `daily-planner` 仍用于从 Vault 视角做完整日计划，而不是取代 app 仓库入口的门禁。
- 旧的 vault-only `pre-dev-sync` / `post-dev-sync` 已进入冻结状态，不再作为普通 app 仓库开发的默认入口。

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
