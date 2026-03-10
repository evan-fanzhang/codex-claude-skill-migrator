param(
    [Parameter(Mandatory = $true)]
    [string]$SkillName,

    [string]$SourceRoot = "$HOME/.claude/skills",

    [string[]]$TargetRoots = @(
        "$HOME/.codex/skills",
        "$HOME/.agents/skills"
    ),

    [switch]$SkipTextRewrite,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

function Write-Utf8NoBom {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Text
    )
    [System.IO.File]::WriteAllText($Path, $Text, [System.Text.UTF8Encoding]::new($false))
}

$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$sourceSkill = Join-Path $SourceRoot $SkillName

if (-not (Test-Path $sourceSkill)) {
    throw "Source skill not found: $sourceSkill"
}

Write-Host "[INFO] Source: $sourceSkill"

foreach ($targetRoot in $TargetRoots) {
    $targetRoot = [System.IO.Path]::GetFullPath($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($targetRoot))
    $targetSkill = Join-Path $targetRoot $SkillName
    $backupRoot = Join-Path $targetRoot '_migration_backup'

    Write-Host "[INFO] Target root: $targetRoot"

    if ($DryRun) {
        Write-Host "[DRYRUN] Ensure target root exists: $targetRoot"
        Write-Host "[DRYRUN] Backup existing target to: $backupRoot"
        Write-Host "[DRYRUN] Copy source to: $targetSkill"
        continue
    }

    New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null
    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null

    if (Test-Path $targetSkill) {
        $backupSkill = Join-Path $backupRoot ("${SkillName}_$timestamp")
        Move-Item $targetSkill $backupSkill -Force
        Write-Host "[INFO] Existing target backed up: $backupSkill"
    }

    Copy-Item $sourceSkill $targetSkill -Recurse -Force
    Write-Host "[INFO] Copied to: $targetSkill"

    $skillMd = Join-Path $targetSkill 'SKILL.md'
    if (Test-Path $skillMd -and -not $SkipTextRewrite) {
        $raw = [System.IO.File]::ReadAllText($skillMd, [System.Text.Encoding]::UTF8)

        # Remove Claude-specific frontmatter keys unsupported by Codex parser.
        $raw = [regex]::Replace($raw, '(?m)^allowed-tools:\s*.*\r?\n', '')
        $raw = [regex]::Replace($raw, '(?m)^argument-hint:\s*.*\r?\n', '')
        $raw = [regex]::Replace($raw, '(?m)^version:\s*.*\r?\n', '')

        # Path/tool/name compatibility adjustments.
        $raw = $raw -replace '~/.claude/', '~/.codex/'
        $raw = $raw -replace '\.claude', '.codex'
        $raw = $raw -replace 'After completing any task, Claude will:', 'After completing any task, Codex will:'
        $raw = [regex]::Replace($raw, '(?m)^Claude will:$', 'Codex will:')

        Write-Utf8NoBom -Path $skillMd -Text $raw
        Write-Host "[INFO] Rewrote compatibility fields: $skillMd"
    }
}

Write-Host "[DONE] Skill migration finished for: $SkillName"