# Definē ceļus (pieņemot, ka fails atrodas tajā pašā mapē)
$sourceFile = "Errors.txt"
$dateStamp = Get-Date -Format "yyyy-MM-dd"
$zipFile = "Atskaite_$dateStamp.zip"

# 1. Izveido arhivētu rezerves kopiju
Compress-Archive -Path $sourceFile -DestinationPath $zipFile -Force

# 2. Iegūst arhīva izmēru un konvertē uz kilobaitiem (KB)
$fileSizeKB = (Get-Item $zipFile).Length / 1KB

# 3. Izvada rezultātu terminālī
Write-Host "Arhīvs izveidots: $zipFile"
Write-Host "Arhīva izmērs: $("{0:N2}" -f $fileSizeKB) KB"
