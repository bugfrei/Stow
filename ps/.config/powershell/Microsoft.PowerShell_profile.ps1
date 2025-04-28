# UPDATE STOW REPO (nur Montags)
if ([DateTime]::Now.DayOfWeek -eq [System.DayOfWeek]::Monday) {
    cd ~/stowdir
    git add .
    git commit -m "Aktuelle Version"
    git push
    cd ~
}

function stopgui {
    [CmdletBinding()]
    [Alias("killgui")]
    param(
    [Switch] $NoRestart
    )

    get-process *sapgui* | Stop-Process
    if (!($NoRestart)) {
        Start-Sleep -Seconds 1
        ii '/Applications/SAP Clients/SAPGUI 7.80rev2/SAPGUI 7.80rev2.app/'
    }
}

function stopall {
    get-process *steam* | Stop-Process
    Get-Process *momentum* | Stop-Process
    Get-Process *discord* | Stop-Process
}
# Kleines Script für die Pipe das JSON in ein Objekt (Default in Variable x) speichert
# z.B. cloc --json | x
# und dann nochmal als Funktions- und Variablenname : o
function x{
    param(
    # Parameter json als Pipe eingabe
    [Parameter(ValueFromPipeline=$true)]
    [string]$json,
    [string]$varName = "x"
)
# In Begin Erst alle Zeilen lesen und in ein String umwandeln

begin{
    $j = ""
}
# In Process den String in ein Objekt umwandeln
process{
    $j += $json
}
end{
    $o = (ConvertFrom-Json -InputObject $j)
    Set-Variable -Name $varName -Scope Global -Value $o
}
}
function o{
    param(
    # Parameter json als Pipe eingabe
    [Parameter(ValueFromPipeline=$true)]
    [string]$json,
    [string]$varName = "o"
)
# In Begin Erst alle Zeilen lesen und in ein String umwandeln

begin{
    $j = ""
}
# In Process den String in ein Objekt umwandeln
process{
    $j += $json
}
end{
    $o = (ConvertFrom-Json -InputObject $j)
    Set-Variable -Name $varName -Scope Global -Value $o
}
}

# Kleines Script das die Ausgabe immer in JSON umwandelt. Default in Variable j
function j{
    param(
    # Parameter json als Pipe eingabe
    [Parameter(ValueFromPipeline=$true)]
    [object]$val,
    [string]$varName = "j",
    [int]$depth = 3
)
# In Begin Erst alle Zeilen lesen und in ein String umwandeln

begin{
    $o = @()
    $j = ""
}
# In Process den String in ein Objekt umwandeln
process{
    if ($json -is [string]){
        $j += $val
    }
    else {
        $o += $val
    }
}
end{
    if ($j -ne ""){
        Set-Variable -Name $varName -Scope Global -Value $j
    }
    else {
        $j = (ConvertTo-Json -InputObject $o -Depth $depth)
        Set-Variable -Name $varName -Scope Global -Value $j
    }
}
}



# Neue Version
#if
#(!(Test-Path Env:TMUX)) {
#    . /Users/carstenschlegel/.local/share/powershell/Modules/PowerShellTools/pstools.ps1
#    tm
#    Get-Date
#    Get-Process -Id $PID | Stop-Process
#    return
#}
function AddOne {
    param( $a )
    return $a + "one"
}
function check {
    param(
    $von,
    $bis
)
cd /Users/carstenschlegel/Coding/Projekte/Testprojekte/IoT/NumberID_Checksum/
if ($von -is [Int]) {
    ./nr.ps1 ($von..$bis) | Join-String ","
}
else {
    $all = ""
    foreach($z in $von) {
        $zz = ./nr.ps1 $z
        $all += "$zz, "
    }
    if ($all.EndsWith(", ")) {
        $all = $all.SubString(0, $all.Length - 2) 
    }

    Set-Clipboard $all
}
popd
}

Function Switch-Profile
{
    [CmdletBinding()]
    [Alias("swpro")]
    param(
    )
    $pf = "/Users/carstenschlegel/.config/powershell/Microsoft.PowerShell_profile.ps1"
    $ps = "/Users/carstenschlegel/.config/powershell/Microsoft.PowerShell_profile_sw.ps1"
    $pt = "/Users/carstenschlegel/.config/powershell/Microsoft.PowerShell_profile_temp.ps1"
    ren $pf $pt
    ren $ps $pf
    ren $pt $ps
    pwsh
}    

$startpath = (Get-Location)

$profilesw = "/Users/carstenschlegel/.config/powershell/Microsoft.PowerShell_profile_sw.ps1"

# Um dieses Profile auch im VSC nutzen zu können, muss es in der Profile-Datei von VSC reinkopiert werden
# = als Platzhalter für Measure-Object
New-Alias -Name pip -Value pip3
New-Alias -Name term -Value zsh
New-Alias -Name vim -Value nvim
New-Alias -Name typem -Value "Show-Markdown"
New-Alias -Name .. -Value ForEach-Object
New-Alias mupdf mupdf-gl
New-Alias -Name todo -Value taskell

# Variablen
$username = [System.Environment]::Username
$icloud = "/Users/$username/Library/Mobile Documents"

$vimrc = "/Users/$username/.config/nvim/init.lua"
$viminst = "/usr/share/vim/vim90"
$gitcfg = "/Users/$username/.gitconfig"
$mod = "/Users/$username/.local/share/powershell/Modules"
$global:__VSCodeOriginalPrompt = "x"
$temp = "/Users/$username/temp"
$dl = "/Users/$username/downloads"
$dok = "/Users/$username/documents"

# Env
$env:RIPGREP_CONFIG_PATH="/Users/carstenschlegel/.ripgreprc"
# Aliase für folgende Cmdlets laden
$WarningPreference = "SilentlyContinue"
Import-Module -Name Path | Out-Null
Import-Module -Name TranslateSearch | Out-Null
Import-Module -Name Commands | Out-Null
Import-Module -Name sup | Out-Null

Import-Module -Name PSYaml | Out-Null
# /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -Silent
Import-Module -Name githelper | Out-Null
Import-Module -Name Helper | Out-Null
. /Users/carstenschlegel/.local/share/powershell/Modules/PowerShellTools/pstools.ps1
$WarningPreference = "Continue"

. /Users/carstenschlegel/Coding/PW/Sup-Crypto/script.ps1

# Cloud Foundry Tools
. /Users/carstenschlegel/Coding/PW/SAPTools/saptools.ps1

# Logtools (cf dmol logs)
. /Users/carstenschlegel/Coding/PW/Logtools/tools.ps1

# UTF8 als Standard Encoding für Get-Content (type) und Out-File
$PSDefaultParameterValues = @{'Get-Content:Encoding' = 'utf8'; 'Out-File:Encoding' = 'utf8' }
# JSON Tiefer von 2 (Default) aus 10 ändern
$PSDefaultParameterValues['ConvertTo-Json:depth'] = 10
#
# Keybindings
if ((Get-PSReadLineOption).EditMode -eq "Vi")
{
    Set-PSReadLineKeyHandler -Key 'F5' -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert(". /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -nocls;"); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); copy /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 /Users/carstenschlegel/Downloads -Force } -BriefDescription "Lädt das SUP Script neu"
    Set-PSReadLineKeyHandler -Key 'F5' -ViMode Insert -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert(". /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -nocls;"); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); copy /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 /Users/carstenschlegel/Downloads -Force } -BriefDescription "Lädt das SUP Script neu"
    Set-PSReadLineKeyHandler -Key ' ,a' -ViMode Command -Function SelectAll
    Set-PSReadLineKeyHandler -Key ' ,h' -ViMode Command -Function ShowKeyBindings
    Set-PSReadLineKeyHandler -Key ' ,k' -ViMode Command -Function WhatIsKey

    Set-PSReadLineKeyHandler -Chord 'v' -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert("v"); } -ViMode Command
}
Set-PSReadLineKeyHandler -Key 'F5' -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert(". /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -nocls;"); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); copy /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 /Users/carstenschlegel/Downloads -Force } -BriefDescription "Lädt das SUP Script neu"

Set-PSReadLineKeyHandler -Key F12 -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert("("); [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")"); } -BriefDescription "Umklammern" -ViMode Insert
Set-PSReadLineKeyHandler -Key F11 -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert("`$xx = ("); [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")"); } -BriefDescription "Umklammern" -ViMode Insert
Set-PSReadLineKeyHandler -Chord Shift+F5 -ViMode Insert -ScriptBlock { $file = "";if (Test-Path reset.ps1) { $file=". ./reset.ps1" } else { if (Test-Path reset.js) { $file="node reset.js"; } } if ($file -ne "") { [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert($file); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); } else { Write-Host "reset.ps1 oder reset.js erstellen" } }
Set-PSReadLineKeyHandler -Chord Shift+F5 -ViMode Command -ScriptBlock { $file = "";if (Test-Path reset.ps1) { $file=". ./reset.ps1" } else { if (Test-Path reset.js) { $file="node reset.js"; } } if ($file -ne "") { [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::Insert($file); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); } else { Write-Host "reset.ps1 oder reset.js erstellen" } }

