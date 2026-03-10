# Codex Claude Skill Migrator Beginner Guide v1.1.0

## English

### 1. Goal
This guide helps beginners migrate one skill from `~/.claude/skills/<skill-name>` to Codex local skill directories with compatibility rewrite and validation.

Project path: `D:\vibe coding\projects\codex-claude-skill-migrator`

Script used: `scripts/migrate_claude_skill.ps1`

### 2. What You Will Get
After migration, the target skill will appear in:
- `~/.codex/skills/<skill-name>`
- `~/.agents/skills/<skill-name>`

The script also performs:
- Remove unsupported frontmatter keys: `allowed-tools`, `argument-hint`, `version`
- Replace hardcoded path `.claude` -> `.codex` (if present in body)
- Replace phrase `Claude will` -> `Codex will`
- Save `SKILL.md` as UTF-8 without BOM
- Backup existing target skill to `<target-root>/_migration_backup/`

### 3. Prerequisites (3 minutes)
Run in PowerShell:

```powershell
# 1) Confirm source skill exists
Get-ChildItem "$HOME/.claude/skills"

# 2) Confirm migration script exists
Get-Item "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1"

# 3) Confirm Codex CLI is available
codex.cmd -V
```

### 4. Step 1: Dry Run First (Required)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -DryRun
```

Example:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName project-worklog -DryRun
```

Expected output includes:
- `[INFO] Source:`
- `[INFO] Target root:`
- `[DRYRUN] Backup existing target to:`
- `[DRYRUN] Copy source to:`

### 5. Step 2: Execute Migration

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name>
```

Success indicators:
- `[DONE] Skill migration finished for: <skill-name>` appears
- `SKILL.md` exists in target directories

```powershell
Get-ChildItem "$HOME/.codex/skills/<skill-name>" -Force
Get-ChildItem "$HOME/.agents/skills/<skill-name>" -Force
```

### 6. Step 3: Validate Migration Result

```powershell
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

Expected: both commands print `Skill is valid!`

### 7. Step 4: Compatibility Spot Check

```powershell
rg -n "allowed-tools|argument-hint|version:|Claude will|\.claude" "$HOME/.codex/skills/<skill-name>/SKILL.md"
rg -n "allowed-tools|argument-hint|version:|Claude will|\.claude" "$HOME/.agents/skills/<skill-name>/SKILL.md"
```

Ideal result:
- no `allowed-tools`, `argument-hint`, `version:`
- no `Claude will`
- no hardcoded `.claude` path in body

### 8. Step 5: Use in Codex
Existing running sessions usually do not hot-load newly migrated skills.

1. Restart `codex`
2. Trigger skill in a new session:

```text
$<skill-name> help me migrate another skill
```

If testing `project-worklog`, try:
- `汇报工作`
- `work log`
- `$project-worklog 汇报工作`

### 9. Troubleshooting
- Access denied on target directories
  - Run in elevated terminal, or grant write permission before migration.
- `No YAML frontmatter found`
  - Ensure `SKILL.md` is UTF-8 without BOM and starts with valid frontmatter.
- `codex` blocked in PowerShell
  - Use `codex.cmd`.

### 10. Advanced Usage
Skip rewrite (copy only):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -SkipTextRewrite
```

Use custom target roots:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -TargetRoots @("$HOME/.codex/skills")
```

### 11. Execution Checklist
- [ ] Source skill confirmed
- [ ] Dry run completed
- [ ] Migration completed
- [ ] Target files verified
- [ ] Validation passed
- [ ] Compatibility spot check completed
- [ ] Codex restart and trigger test completed

### 12. Rollback
If migration result is not acceptable:
1. Locate backup folders:
- `~/.codex/skills/_migration_backup/`
- `~/.agents/skills/_migration_backup/`
2. Remove current target skill
3. Restore backup folder name to original skill name

### 13. Version
- Guide version: `v1.1.0`
- Project version file: `D:\vibe coding\projects\codex-claude-skill-migrator\VERSION`
- Last updated: 2026-03-10

---

## 中文

### 1. 指南目标
本指南面向新手，帮助你将 `~/.claude/skills/<skill-name>` 迁移到 Codex 本地技能目录，并完成兼容改写与校验。

适用项目路径：`D:\vibe coding\projects\codex-claude-skill-migrator`

使用脚本：`scripts/migrate_claude_skill.ps1`

### 2. 你将获得的结果
迁移完成后，目标 skill 会出现在：
- `~/.codex/skills/<skill-name>`
- `~/.agents/skills/<skill-name>`

脚本会自动执行：
- 删除不兼容 frontmatter 字段：`allowed-tools`、`argument-hint`、`version`
- 将正文中的硬编码路径 `.claude` 替换为 `.codex`
- 将文案 `Claude will` 替换为 `Codex will`
- 将 `SKILL.md` 保存为 UTF-8 无 BOM
- 若目标已有同名 skill，先备份到 `<target-root>/_migration_backup/`

### 3. 前置检查（约3分钟）
在 PowerShell 运行：

```powershell
# 1) 确认源 skill 存在
Get-ChildItem "$HOME/.claude/skills"

# 2) 确认迁移脚本存在
Get-Item "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1"

# 3) 确认 Codex CLI 可用
codex.cmd -V
```

### 4. 第一步：先做 Dry Run（必做）

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -DryRun
```

示例：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName project-worklog -DryRun
```

期望输出包含：
- `[INFO] Source:`
- `[INFO] Target root:`
- `[DRYRUN] Backup existing target to:`
- `[DRYRUN] Copy source to:`

### 5. 第二步：执行正式迁移

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name>
```

成功标志：
- 出现 `[DONE] Skill migration finished for: <skill-name>`
- 目标目录中能看到 `SKILL.md`

```powershell
Get-ChildItem "$HOME/.codex/skills/<skill-name>" -Force
Get-ChildItem "$HOME/.agents/skills/<skill-name>" -Force
```

### 6. 第三步：校验迁移结果

```powershell
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

期望：两条命令都输出 `Skill is valid!`

### 7. 第四步：兼容改写抽查

```powershell
rg -n "allowed-tools|argument-hint|version:|Claude will|\.claude" "$HOME/.codex/skills/<skill-name>/SKILL.md"
rg -n "allowed-tools|argument-hint|version:|Claude will|\.claude" "$HOME/.agents/skills/<skill-name>/SKILL.md"
```

理想结果：
- 不再出现 `allowed-tools`、`argument-hint`、`version:`
- 不再出现 `Claude will`
- 正文中不再硬编码 `.claude`

### 8. 第五步：在 Codex 中使用
已运行中的会话通常不会热加载新迁移 skill。

1. 重启 `codex`
2. 在新会话里触发：

```text
$<skill-name> help me migrate another skill
```

如果测试 `project-worklog`，可输入：
- `汇报工作`
- `work log`
- `$project-worklog 汇报工作`

### 9. 常见问题
- 目标目录 Access denied
  - 用管理员权限终端执行，或先授予写权限。
- `No YAML frontmatter found`
  - 确保 `SKILL.md` 是 UTF-8 无 BOM，且 frontmatter 格式正确。
- PowerShell 无法执行 `codex`
  - 改用 `codex.cmd`。

### 10. 进阶用法
仅复制不改写：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -SkipTextRewrite
```

自定义目标目录：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\vibe coding\projects\codex-claude-skill-migrator\scripts\migrate_claude_skill.ps1" -SkillName <skill-name> -TargetRoots @("$HOME/.codex/skills")
```

### 11. 执行清单
- [ ] 已确认源 skill
- [ ] 已执行 Dry Run
- [ ] 已执行正式迁移
- [ ] 已确认目标文件
- [ ] 已完成校验
- [ ] 已完成兼容抽查
- [ ] 已重启 Codex 并触发测试

### 12. 回滚方法
若迁移结果不符合预期：
1. 找到备份目录：
- `~/.codex/skills/_migration_backup/`
- `~/.agents/skills/_migration_backup/`
2. 删除当前目标 skill
3. 将备份目录重命名回原 skill 名

### 13. 版本
- 指南版本：`v1.1.0`
- 项目版本文件：`D:\vibe coding\projects\codex-claude-skill-migrator\VERSION`
- 最后更新：2026-03-10