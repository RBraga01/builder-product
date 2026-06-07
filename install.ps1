# builder-product install script for Windows
param([string]$Target = ".")

$Repo = "https://github.com/RBraga01/builder-product"
$Pack = "builder-product"

Write-Host "Installing $Pack into $Target..." -ForegroundColor Cyan

$Tmp = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $Tmp | Out-Null

try {
    git clone --filter=blob:none --sparse $Repo "$Tmp\$Pack" --quiet
    Set-Location "$Tmp\$Pack"
    git sparse-checkout set skills .claude
    Set-Location -
} catch {
    Write-Error "Clone failed: $_"
    exit 1
} finally {
    if (Test-Path $Tmp) { Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue }
}

if (-not (Test-Path "$Target\skills")) { Copy-Item -Recurse "$Tmp\$Pack\skills" "$Target\" }
if (-not (Test-Path "$Target\.claude")) { Copy-Item -Recurse "$Tmp\$Pack\.claude" "$Target\" }

Write-Host "Done. Skills installed to $Target\skills\" -ForegroundColor Green
Write-Host "Agents installed to $Target\.claude\agents\" -ForegroundColor Green
Write-Host ""
Write-Host "Start with: prd-quality-gate -> feature-scoping -> metric-definition"
