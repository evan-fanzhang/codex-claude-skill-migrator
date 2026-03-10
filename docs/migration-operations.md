# Claude Skill to Codex Skill Migration Operations

## Goal
Migrate a Claude skill into Codex local skill directories in a repeatable and safe workflow.

## Standard Workflow
1. Inspect source and target folders.
2. Run migration script in `-DryRun` mode.
3. Run migration script in normal mode.
4. Validate migrated skill with `quick_validate.py`.
5. Smoke-test skill in a new Codex session.

## Reference Commands
```powershell
# list source skills
Get-ChildItem "$HOME/.claude/skills"

# dry run
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name> -DryRun

# execute migration
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name>

# validate
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.codex/skills/<skill-name>"
python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$HOME/.agents/skills/<skill-name>"
```

## Compatibility Rewrite Rules
- Remove frontmatter keys: `allowed-tools`, `argument-hint`, `version`
- Replace `.claude` path references with `.codex`
- Replace phrase `Claude will` with `Codex will`
- Write `SKILL.md` as UTF-8 without BOM

## Rollback
If migration result is not acceptable, restore from:
- `~/.codex/skills/_migration_backup/`
- `~/.agents/skills/_migration_backup/`