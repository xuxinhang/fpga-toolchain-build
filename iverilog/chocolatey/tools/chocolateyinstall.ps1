$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$archivePath = "$toolsPath\_archives"

Get-ChocolateyUnzip `
    -FileFullPath   (Get-Item "$archivePath/*mingw*i686*")[0] `
    -FileFullPath64 (Get-Item "$archivePath/*mingw*x86_64*")[0] `
    -Destination    $toolsPath

Remove-Item -Recurse -Force $archivePath
