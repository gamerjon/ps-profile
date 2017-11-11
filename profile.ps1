# Import module from previous step
#Import-Module -Name posh-git

#Start-SshAgent

Write-Host ""

# $ScriptPath = Split-Path -parent $PSCommandPath
# . "$ScriptPath\Get-ChildItem-Color\Get-ChildItem-Color.ps1"
# Set-Alias ls Get-ChildItem-Color -Option AllScope -Force
# Set-Alias dir Get-ChildItem-Color -option AllScope -Force

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

$global:foregroundColor = 'white'
$time = Get-Date
$psVerMaj= $host.Version.Major
$psVerMin= $host.Version.Minor
$curUser= (Get-ChildItem Env:\USERNAME).Value
$curComp= (Get-ChildItem Env:\COMPUTERNAME).Value
$isElevated = "NORMAL "
$elevatedColor = "Blue"
$grammar = "a "

if (Test-Administrator) {  # Use different username if elevated
	$isElevated = "ELEVATED "
	$elevatedColor = "Red"
	$grammar = "an "
}

Write-Host "Greetings, " -NoNewline -foregroundColor $foregroundColor
Write-Host "$curUser" -NoNewline -foregroundColor DarkYellow
Write-Host "!" -foregroundColor $foregroundColor
Write-Host "It is: $($time.ToLongDateString())"
Write-Host "You're running $grammar" -NoNewline -foregroundColor Green
Write-Host "$isElevated" -NoNewline -foregroundColor $elevatedColor
Write-Host "PowerShell $psVerMaj.$psVerMin session" -foregroundColor Green
Write-Host "Your computer name is: $curComp" -foregroundColor Green
Write-Host "Happy scripting!"

<# function Prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
		$isElevated = "(Elevated)"
    }

    Write-Host "$curUser@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$curComp" -NoNewline -ForegroundColor Magenta

    if ($s -ne $null) {  # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host ""

    $host.UI.RawUI.WindowTitle = "$isElevated PS >> User: $curUser >> Current DIR: $((Get-Location).Path)"

    return "> "

} #>
