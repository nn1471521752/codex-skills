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
        [string[]]$ExcludeDirectories = @(),
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

    $arguments = @($Source, $Target, "*") + $flags
    foreach ($directory in $ExcludeDirectories) {
        $arguments += @("/XD", $directory)
    }

    & robocopy @arguments | Out-Null
    $exitCode = $LASTEXITCODE
    if ($exitCode -ge 8) {
        throw "robocopy failed: $Source -> $Target (exit code $exitCode)"
    }
}

function Copy-ManagedFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Target
    )

    if (-not (Test-Path $Source)) {
        throw "Source file does not exist: $Source"
    }

    $targetDirectory = Split-Path -Parent $Target
    if ($targetDirectory) {
        New-Item -ItemType Directory -Force -Path $targetDirectory | Out-Null
    }

    Copy-Item -Force -Path $Source -Destination $Target
}

$skillsSource = Join-Path $RepoRoot "skills"
$superpowersSource = Join-Path $RepoRoot "superpowers"
$agentsSource = Join-Path $RepoRoot "AGENTS.md"

$skillsTarget = Join-Path $CodexHome "skills"
$superpowersTarget = Join-Path $CodexHome "superpowers"
$agentsTarget = Join-Path $CodexHome "AGENTS.md"

Sync-Tree -Source $skillsSource -Target $skillsTarget -ExcludeDirectories @((Join-Path $skillsSource ".git")) -MirrorMode:$Mirror
Sync-Tree -Source $superpowersSource -Target $superpowersTarget -ExcludeDirectories @((Join-Path $superpowersSource ".git")) -MirrorMode:$Mirror
Copy-ManagedFile -Source $agentsSource -Target $agentsTarget

Write-Host "Installed Codex global files from $RepoRoot into $CodexHome"
