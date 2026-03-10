# codex-claude-skill-migrator

Beginner guide / 新手请看陪跑指南: [docs/codex-claude-skill-migrator-beginner-guide-v1.1.0.md](docs/codex-claude-skill-migrator-beginner-guide-v1.1.0.md)

## English

Migrate one Claude Code skill from `~/.claude/skills` to Codex local skill folders with backup, compatibility rewrite, and validation.

### What This Project Does
- Migrates a skill folder to:
  - `~/.codex/skills/<skill-name>`
  - `~/.agents/skills/<skill-name>`
- Backs up existing target skills to `_migration_backup`.
- Rewrites common compatibility issues in `SKILL.md`:
  - removes `allowed-tools`, `argument-hint`, `version`
  - rewrites `.claude` path references to `.codex`
  - rewrites `Claude will` to `Codex will`
  - saves file as UTF-8 without BOM
- Supports dry-run mode.

### Repository Layout
- `scripts/`: reusable migration script
- `skill/claude-skill-migrator/`: local Codex skill package
- `docs/`: operation and usage notes
- `logs/`: sample migration log

### Quick Start
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name> -DryRun
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name>
```

### Validate Result
```powershell
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

### Notes
- If your terminal blocks `codex.ps1`, use `codex.cmd`.
- If you see permission errors on `.codex/skills` or `.agents/skills`, run with elevated permissions.

---

## 中文

将单个 Claude Code skill 从 `~/.claude/skills` 迁移到 Codex 本地技能目录，并自动完成备份、兼容改写和校验。

### 项目功能
- 将 skill 迁移到：
  - `~/.codex/skills/<skill-name>`
  - `~/.agents/skills/<skill-name>`
- 将目标目录中已有同名 skill 备份到 `_migration_backup`。
- 自动改写 `SKILL.md` 中常见兼容问题：
  - 删除 `allowed-tools`、`argument-hint`、`version`
  - 将正文中的 `.claude` 路径改为 `.codex`
  - 将 `Claude will` 改为 `Codex will`
  - 统一保存为 UTF-8 无 BOM
- 支持 `DryRun` 预演模式。

### 仓库结构
- `scripts/`：可复用迁移脚本
- `skill/claude-skill-migrator/`：可安装到 Codex 的本地 skill 包
- `docs/`：操作说明与指南
- `logs/`：示例迁移日志

### 快速开始
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name> -DryRun
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name>
```

### 结果校验
```powershell
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

### 说明
- 若 PowerShell 阻止 `codex.ps1`，请改用 `codex.cmd`。
- 若 `.codex/skills` 或 `.agents/skills` 报权限错误，请使用提升权限终端执行。