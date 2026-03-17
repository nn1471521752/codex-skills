# AGENTS

## 用途

- 这是当前用户全局 `Codex` 能力的 git 源仓库。
- 仓库内的 `AGENTS.md`、`skills/`、`superpowers/` 是全局工作流的事实来源。

## 来源与安装关系

- 仓库根目录的 `AGENTS.md` 安装到 `%USERPROFILE%\.codex\AGENTS.md`。
- `skills/` 安装到 `%USERPROFILE%\.codex\skills`。
- `superpowers/` 安装到 `%USERPROFILE%\.codex\superpowers`。
- 安装入口是 [install-global-skills.ps1](/E:/codex-skills/scripts/install-global-skills.ps1)。
- 不要直接把 `%USERPROFILE%\.codex\skills`、`%USERPROFILE%\.codex\superpowers`、`%USERPROFILE%\.codex\AGENTS.md` 当作长期手改源；应优先修改此仓库后再执行安装脚本。

## 编码约束

- 仓库内所有文本文件默认使用 UTF-8，并受 `.editorconfig` 与 `.gitattributes` 约束。
- 新建或重写 `*.md`、`*.txt`、`*.json`、`*.yaml`、`*.yml`、`*.toml`、`*.js`、`*.jsx`、`*.ts`、`*.tsx`、`*.mjs`、`*.cjs`、`*.css`、`*.html`、`*.py`、`*.ps1`、`*.sh`、`*.sql`、`*.svg` 等文本文件时，必须显式使用 UTF-8。
- 使用 PowerShell 写文件时，禁止依赖默认编码或 `>`、`>>`、`Out-File`、`Set-Content` 的默认行为；必须显式指定 UTF-8。
- 如果发现乱码，先从 git 恢复到最后一个正常版本，再重新应用改动；不要直接在乱码文件上继续保存。

## 输出约束

- 除非用户明确指定其他语言，生成或导出的 `doc` 文件默认使用中文内容与中文标题。
- 如果某条工作流需要输出中英双语，必须在任务说明里显式写明，不默认混用。

## 修改边界

- 不要把 `config.toml`、`auth.json`、`sqlite/`、`sessions/`、日志、缓存或其他本机状态文件纳入这个仓库。
- `superpowers/` 在这个仓库里按 vendor snapshot 管理；需要更新时，在仓库内完成并通过安装脚本同步，不依赖安装目录里的 `.git` 元数据。
- 结束修改前，确认 `README.md`、安装脚本和本仓库规则没有互相冲突。
