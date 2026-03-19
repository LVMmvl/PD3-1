$logPath = "$HOME\Documents\Apkope.log"
$drive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$freePercent = ($drive.FreeSpace / $drive.Size) * 100
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

if ($freePercent -lt 25) {
    
    $before = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    
    
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
    
    
    $after = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $freedGB = [Math]::Round(($before - $after) / 1GB, 2)
    
    
    "[$timestamp] Tīrīšana veikta. Atbrīvoti $freedGB GB." | Out-File $logPath -Append
} else {
    
    "[$timestamp] Vieta pietiekama." | Out-File $logPath -Append
}

