# 1. Iegūst sarakstu ar programmām, kurām ir pieejami atjauninājumi
Write-Host "Pārbauda pieejamos programmatūras atjauninājumus..." -ForegroundColor Cyan
$updates = winget upgrade --include-unknown | Out-String

# 2. Pārbauda, vai ir atrasti atjauninājumi
if ($updates -match "No installed package have yielded yields") {
    Write-Host "Visi rīki ir atjaunināti!" -ForegroundColor Green
} else {
    # 3. Izvada sarakstu terminālī
    Write-Host "Pieejamie atjauninājumi:" -ForegroundColor Yellow
    winget upgrade
}

