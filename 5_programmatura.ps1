
Write-Host "Pārbauda pieejamos programmatūras atjauninājumus..." -ForegroundColor Cyan
$updates = winget upgrade --include-unknown | Out-String


if ($updates -match "No installed package have yielded yields") {
    Write-Host "Visi rīki ir atjaunināti!" -ForegroundColor Green
} else {
    
    Write-Host "Pieejamie atjauninājumi:" -ForegroundColor Yellow
    winget upgrade
}

