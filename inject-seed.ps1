# inject-seed.ps1
# Re-syncs the embedded `const SEED = {...};` block inside index.html
# with the current contents of data/ideas.json.
#
# Run from anywhere:
#   powershell -NoProfile -ExecutionPolicy Bypass -File ai-innovation-portal\inject-seed.ps1
#
# Why: when the portal is opened by double-clicking (file://), browsers block
# fetch() of local JSON, so index.html falls back to this embedded SEED.
# Keeping SEED in sync with data/ideas.json means the double-click view always
# matches the committed source of truth.

$ErrorActionPreference = "Stop"
$here     = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlPath = Join-Path $here "index.html"
$jsonPath = Join-Path $here "data\ideas.json"

if (-not (Test-Path $htmlPath)) { throw "index.html not found at $htmlPath" }
if (-not (Test-Path $jsonPath)) { throw "data/ideas.json not found at $jsonPath" }

$json = Get-Content -Raw -Path $jsonPath
$html = Get-Content -Raw -Path $htmlPath

# Replace everything from `const SEED = {` up to the closing `};`
# (the first `};` that terminates the object, followed by a newline and `const STAGES`).
$pattern     = '(?s)const SEED = \{.*?\n\};'
$replacement = 'const SEED = ' + $json.TrimEnd() + ';'

if ($html -notmatch 'const SEED = \{') {
    throw "Could not find 'const SEED = {' block in index.html"
}

# Use [regex]::Replace to avoid $-substitution issues with the JSON content.
$re      = [regex]::new($pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
$newHtml = $re.Replace($html, [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $replacement }, 1)

if ($newHtml -eq $html) {
    throw "SEED block was not replaced (no change made). Check the pattern."
}

Set-Content -Path $htmlPath -Value $newHtml -NoNewline -Encoding UTF8
Write-Host "SEED re-synced from data/ideas.json into index.html."
