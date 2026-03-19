$sourceFile = "Errors.txt"
$dateStamp = Get-Date -Format "yyyy-MM-dd"
$zipFile = "Atskaite_$dateStamp.zip"


Compress-Archive -Path $sourceFile -DestinationPath $zipFile -Force


$fileSizeKB = (Get-Item $zipFile).Length / 1KB


Write-Host "Arhīvs izveidots: $zipFile"
Write-Host "Arhīva izmērs: $("{0:N2}" -f $fileSizeKB) KB"

