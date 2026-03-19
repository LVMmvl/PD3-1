# 1. Iegūst winget izvadi un pārvērš to sarakstā
Write-Host "Pārbauda pieejamos atjauninājumus..." -ForegroundColor Cyan
$updates = winget upgrade --include-unknown | Out-String

# 2. Apstrādā tekstu, lai saskaitītu tikai programmu rindas
# Filtrējam ārā tabulas galvenes, atdalītājus un tukšas rindas
$updateLines = $updates -split "`r`n" | Where-Object { 
    $_ -match '\d+\.\d+' -and 
    $_ -notmatch 'Name|ID|Version|---|atjauninājumi'
}

$count = ($updateLines | Measure-Object).Count

# 3. Izvada rezultātus terminālī
if ($count -gt 0) {
    Write-Host "Atrasti $count programmu atjauninājumi:" -ForegroundColor Yellow
    winget upgrade --include-unknown
} else {
    Write-Host "Visi rīki ir atjaunināti!" -ForegroundColor Green
}

Write-Host "`nKopā pieejami atjauninājumi: $count" -ForegroundColor White
