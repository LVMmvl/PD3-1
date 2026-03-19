# 1. Definē ceļus un mainīgos
$logPath = "$HOME\Documents\Apkope.log"
$drive = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$freePercent = ($drive.FreeSpace / $drive.Size) * 100
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 2. Pārbauda brīvo vietu (mazāk par 25%)
if ($freePercent -lt 25) {
    # Nomēra vietu pirms tīrīšanas
    $before = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    
    # Iztīra Temp mapi un Atkritni
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
    
    # Nomēra vietu pēc tīrīšanas un aprēķina starpību GB
    $after = (Get-ChildItem $env:TEMP -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $freedGB = [Math]::Round(($before - $after) / 1GB, 2)
    
    # Ieraksta žurnālfailā
    "[$timestamp] Tīrīšana veikta. Atbrīvoti $freedGB GB." | Out-File $logPath -Append
} else {
    # Ja vietas pietiek
    "[$timestamp] Vieta pietiekama." | Out-File $logPath -Append
}

