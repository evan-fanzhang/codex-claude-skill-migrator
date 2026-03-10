# codex-claude-skill-migrator

Migrate one Claude Code skill from `~/.claude/skills` to Codex local skill folders with backup, compatibility rewrite, and validation.

## What This Project Does
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

## Repository Layout
- `scripts/`: reusable migration script
- `skill/claude-skill-migrator/`: local Codex skill package
- `docs/`: operation and usage notes
- `logs/`: sample migration log

## Quick Start
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name> -DryRun
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name>
```

## Validate Result
```powershell
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

## Notes
- If your terminal blocks `codex.ps1`, use `codex.cmd`.
- If you see permission errors on `.codex/skills` or `.agents/skills`, run with elevated permissions.