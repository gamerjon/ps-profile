# Creates a $PROFILE if one does not already exist
if (-Not (Test-Path $PROFILE)) {
    New-Item $PROFILE –Type File –Force
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

if (-Not (Test-Path $PROFILE)) {
    New-Item $PROFILE –Type File –Force
}

# Modules to import
Import-Module posh-git
Import-Module posh-docker
Import-Module oh-my-posh
Import-Module PSColor

# Set-Theme for oh-myposh module
Set-Theme paradox

# CLI history exported to GUI grid view
Function hplus{Iex "$((h|ogv -PassThru).commandline)"}

# Shortcut to system32 folder
Function CD32 {set-location c:\windows\system32}

# "grep" the formatted output (display strings) as a stream of strings
function pgrep {
  $input | out-string -stream | select-string $args
}

Function Get-IPAddress {
 (Get-WmiObject -class win32_NetworkAdapterConfiguration `
   -Filter 'ipenabled = "true"').ipaddress[0]
} 

Function Get-IPs {
 ipconfig | Select-String -Pattern "IPv4"
}

# Alias to set
Set-Alias d docker
Set-Alias dm docker-machine
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias goto Set-Location
Set-Alias gh get-help
Set-Alias np c:\windows\notepad.exe
Set-Alias npp "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias go cd32
Set-Alias gia get-ipaddress
Set-Alias gips get-ips

# Startup items
Start-SshAgent