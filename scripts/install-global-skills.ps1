param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$CodexHome = (Join-Path $env:USERPROFILE ".codex"),
    [switch]$Mirror
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Sync-Tree {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Target,
        [switch]$MirrorMode
    )

    if (-not (Test-Path $Source)) {
        throw "Source path does not exist: $Source"
    }

    New-Item -ItemType Directory -Force -Path $Target | Out-Null

    $flags = @("/E", "/R:1", "/W:1", "/NFL", "/NDL", "/NJH", "/NJS", "/NP")
    if ($MirrorMode) {
        $flags = @("/MIR", "/R:1", "/W:1", "/NFL", "/NDL", "/NJH", "/NJS", "/NP")
    }

    & robocopy $Source $Target * $flags | Out-Null
    $exitCode = $LASTEXITCODE
    if ($exitCode -ge 8) {
        throw "robocopy failed: $Source -> $Target (exit code $exitCode)"
    }
}

$skillsSource = Join-Path $RepoRoot "skills"
$superpowersSource = Join-Path $RepoRoot "superpowers"

$skillsTarget = Join-Path $CodexHome "skills"
$superpowersTarget = Join-Path $CodexHome "superpowers"

Sync-Tree -Source $skillsSource -Target $skillsTarget -MirrorMode:$Mirror
Sync-Tree -Source $superpowersSource -Target $superpowersTarget -MirrorMode:$Mirror

Write-Host "Installed Codex skills from $RepoRoot into $CodexHome"
