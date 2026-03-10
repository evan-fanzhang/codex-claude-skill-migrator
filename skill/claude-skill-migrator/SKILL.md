---
name: claude-skill-migrator
description: Migrate one Claude Code skill from ~/.claude/skills into Codex local skill directories, apply compatibility rewrites for SKILL.md, and validate migration results. Use when users ask to reuse/migrate Claude skills in Codex.
---

# Claude Skill Migrator

## Workflow
1. Confirm source skill exists in `~/.claude/skills/<skill-name>`.
2. Backup existing target skill (if any) to `<target-root>/_migration_backup/<skill-name>_<timestamp>`.
3. Copy source skill into targets:
- `~/.codex/skills`
- `~/.agents/skills`
4. Rewrite `SKILL.md` for Codex compatibility:
- Remove frontmatter keys: `allowed-tools`, `argument-hint`, `version`
- Replace hardcoded `.claude` paths with `.codex` if present
- Replace phrase `Claude will` with `Codex will` where applicable
- Ensure file encoding is UTF-8 without BOM
5. Validate target skill using:
- `python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py <target-skill-dir>`
6. Report final paths, compatibility edits, and validation results.

## Script
Use `scripts/migrate_claude_skill.ps1`:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/migrate_claude_skill.ps1 -SkillName <skill-name>
```

Optional:
- `-SkipTextRewrite`
- `-DryRun`