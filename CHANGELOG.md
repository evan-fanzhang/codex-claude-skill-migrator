# Changelog

All notable changes to this project are documented in this file.

## [v1.1.0] - 2026-03-10
### Added
- Added bilingual `README.md` layout (English first, then Chinese).
- Added beginner guide link at the top of README.
- Added bilingual beginner guide with all-English filename:
  - `docs/codex-claude-skill-migrator-beginner-guide-v1.1.0.md`

### Changed
- Updated `VERSION` from `1.0` to `1.1.0`.
- Reorganized docs for beginner onboarding and clearer execution flow.

### Removed
- Removed old Chinese-named beginner guide file from local guide folder.

---

## [v1.0] - 2026-03-10
### Added
- Initial public release branch (`public-main`).
- Reusable migration script:
  - `scripts/migrate_claude_skill.ps1`
- Local skill package:
  - `skill/claude-skill-migrator/SKILL.md`
  - `skill/claude-skill-migrator/scripts/migrate_claude_skill.ps1`
- Public repo baseline files:
  - `README.md`, `LICENSE`, `.gitignore`, `CONTRIBUTING.md`

### Notes
- Migrates Claude skills into Codex local skill directories with backup and compatibility rewrite.

---

## 中文说明

### [v1.1.0] - 2026-03-10
#### 新增
- `README.md` 调整为中英双语排版（英文在前、中文在后）。
- 在 README 顶部新增新手陪跑指南链接。
- 新增双语新手陪跑指南（全英文文件名）：
  - `docs/codex-claude-skill-migrator-beginner-guide-v1.1.0.md`

#### 变更
- `VERSION` 从 `1.0` 升级为 `1.1.0`。
- 文档结构优化，更适合新手按步骤执行。

#### 移除
- 删除本地陪跑目录中的旧中文文件名指南。

### [v1.0] - 2026-03-10
#### 新增
- 首个公开发布分支（`public-main`）。
- 迁移脚本：`scripts/migrate_claude_skill.ps1`
- 本地 skill 包：
  - `skill/claude-skill-migrator/SKILL.md`
  - `skill/claude-skill-migrator/scripts/migrate_claude_skill.ps1`
- 开源基础文件：`README.md`、`LICENSE`、`.gitignore`、`CONTRIBUTING.md`

#### 说明
- 项目用于将 Claude skill 迁移到 Codex 本地 skill 目录，并自动完成备份与兼容改写。