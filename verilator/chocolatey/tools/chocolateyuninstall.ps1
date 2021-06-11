$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Get-Item $toolsPath/bin/*.bat | Foreach-Object { `
    Uninstall-BinFile -Name $_.BaseName `
}
