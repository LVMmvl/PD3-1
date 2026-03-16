$topProcesses = Get-Process | 
    Where-Object { $_.ProcessName -ne 'svchost' } | 
    Sort-Object WorkingSet -Descending | 
    Select-Object -First 5 ProcessName, @{Name='RAM_MB'; Expression={[math]::Round($_.WorkingSet / 1MB, 2)}}

$topProcesses | Format-Table -AutoSize


$totalRAM_MB = ($topProcesses | Measure-Object -Property RAM_MB -Sum).Sum
Write-Host ("Total RAM used by top 5 processes (excluding svchost): {0:N2} MB" -f $totalRAM_MB)
