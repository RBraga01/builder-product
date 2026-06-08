# builder-product install script for Windows
param([string]$Target = ".")

$Repo = "https://github.com/RBraga01/builder-product"
$Pack = "builder-product"
$MinGitMajor = 2; $MinGitMinor = 25

Write-Host "Installing $Pack into $Target..." -ForegroundColor Cyan

# Verify target directory exists
if (-not (Test-Path $Target -PathType Container)) {
    Write-Error "Target directory '$Target' does not exist."
    exit 1
}

# Check git version
try {
    $gitVersion = (git --version) -replace "git version ", ""
    $parts = $gitVersion.Split(".")
    if ([int]$parts[0] -lt $MinGitMajor -or ([int]$parts[0] -eq $MinGitMajor -and [int]$parts[1] -lt $MinGitMinor)) {
        Write-Error "git >= $MinGitMajor.$MinGitMinor required (found $gitVersion). Please upgrade git."
        exit 1
    }
} catch {
    Write-Error "git not found. Please install git >= $MinGitMajor.$MinGitMinor."
    exit 1
}

$Tmp = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $Tmp | Out-Null

try {
    git clone --filter=blob:none --sparse $Repo "$Tmp\$Pack" --quiet
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }

    Set-Location "$Tmp\$Pack"
    git sparse-checkout set skills .claude
    if ($LASTEXITCODE -ne 0) { throw "git sparse-checkout failed" }
    Set-Location -

    if (-not (Test-Path "$Target\skills")) {
        Copy-Item -Recurse "$Tmp\$Pack\skills" "$Target\"
    }
    if (-not (Test-Path "$Target\.claude")) {
        Copy-Item -Recurse "$Tmp\$Pack\.claude" "$Target\"
    }

    Write-Host "Done. Skills installed to $Target\skills\" -ForegroundColor Green
    Write-Host "Agents installed to $Target\.claude\agents\" -ForegroundColor Green
    Write-Host ""
    Write-Host "Start with: prd-quality-gate -> feature-scoping -> metric-definition"
} catch {
    Write-Error "Install failed: $_"
    exit 1
} finally {
    if (Test-Path $Tmp) { Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue }
}
