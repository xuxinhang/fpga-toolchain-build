# Write-Host "Install script started."

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$archievesPath = "$toolsPath\_archieves"

Get-ChocolateyUnzip `
    -FileFullPath   "$archievesPath\mingw32-w64-i686.zip" `
    -FileFullPath64 "$archievesPath\mingw32-w64-x86_64.zip" `
    -Destination    $toolsPath

Remove-Item -Recurse -Force $archievesPath

# Write-Host "Install script finished."
