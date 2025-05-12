# UPDATE STOW REPO (nur Montags)
#if ([DateTime]::Now.DayOfWeek -eq [System.DayOfWeek]::Monday) {
#    cd ~/stowdir
#    git add .
#    git commit -m "Aktuelle Version"
#    git push
#    cd ~
#}

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
    get-process "Steam Helper" | Stop-Process
    get-process "steam_osx" | Stop-Process
    Get-Process *momentum* | Stop-Process
    Get-Process *discord* | Stop-Process
    Get-Process *vlc* | Stop-Process
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

# Ausgabe von Informationen
function info
{
    param(
        [Switch] $nocls
    )
    if (-not $nocls)
    {
        cls
    }
    Write-Host "YouTube (y), Bing (b), Google (g), Get-English (en), Get-German (de), Start-Search (suche), Projekt" -ForeGroundColor Red
    Write-Host "vim `$profile, vimrc, vim `$gitcfg" -ForegroundColor Gray
    Write-Host "Compress-Archive <files> <archivename.zip>  |  Expand-Archive <archivename.zip> <destPath>" -ForegroundColor Yellow
    Write-Host
}
. "/Users/carstenschlegel/Library/Application Support/.btp/autocomplete/scripts/sapbtpcli-autocomplete.plugin.ps1"

function Remote
{
    [Alias("Connect", "Con")]
    param(
    )
    $s = New-PSSession -hostName 82.165.56.11 -UserName root 
    $Global:Session = $s
    return $s
}
function Enter
{
    param(
        $session = $null
    )
    if ($session -is [String]) {
        ssh $session
    }
    else {
        if ($session -eq $null)
        {
            $s = $Global:Session
        }
        else
        {
            $s = $session
        }
        if ($session -eq $null) {
            ssh vm -t pwsh
        }
        else {
            Enter-PSSession $s
        }
    }
}


cd ~
info -nocls

function mc
{
    if ($session.State -ne "Opened")
    {
        connect | Out-Null
    }
    Invoke-Command -Session $session -ScriptBlock { docker logs --since 24h mc; Read-Host 'Enter for Stats'; docker container stats mc }
}

function aus
{
    param(
        $z,
        $dividator = 3
    )
    $s = ($z - ($z % $dividator)) / $dividator; 1..$dividator | ForEach-Object { $z - ( $s * $_ ) }
}


# Text2MP3
function VoiceArgumentCompleter
{
    param(
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )
    if ($Global:_voices -eq $null)
    {
        $key = "b2da8862091c6f36d5fbbfc09fa74bcf"

        $headers = @{
            'xi-api-key' = $key
        }

        $url = "https://api.elevenlabs.io/v1/voices"

        $Global:_voices = Invoke-RestMethod -Uri $url -Method Get -Headers $headers -ContentType "application/json" 
    }

    foreach ($voice in $Global:_voices.voices)
    {
        if ($voice.name -match "$wordToComplete.*")
        {
            $tt = "Akzent: $($voice.labels.accent), Alter: $($voice.labels.age), Geschlecht: $($voice.labels.gender)"
            New-Object System.Management.Automation.CompletionResult (
                $voice.name,
                $voice.name,
                "ParameterValue",
                $tt
            )
        }
    }
}
    
function Load-TextVoice
{
    [CmdletBinding()]
    [Alias("voice", "mp3", "text")]
    param(
        [ArgumentCompleter({ VoiceArgumentCompleter @args })]
        [string] $Voice,
        $FileMP3,
        $Text

    )

    $v = $Global:_voices.voices | Where-Object { $_.name -eq $Voice }
    $vid = "21m00Tcm4TlvDq8ikWAM"
    if ($v.Count -eq 1)
    {
        $vid = $v.voice_id
    }
    elseif ($v.Count -gt 1)
    {
        Write-Host "Mehere Voices gefunden! - Abbruch" -ForegroundColor Red
        return
    }
    else
    {
        Write-Host "Standard-Voice wird verwendet"
    }
    
    $body = [PSCustomObject]@{
        text           = $Text
        model_id       = "eleven_monolingual_v1"
        voice_settings = [PSCustomObject]@{
            stability        = 0.5
            similarity_boost = 0.5
        }
    }
    $bodyJson = ConvertTo-Json -InputObject $body -Depth 3
    $key = "b2da8862091c6f36d5fbbfc09fa74bcf"

    $headers = @{
        'xi-api-key'      = $key
        "Accept"          = "*/*"
        "Accept-Encoding" = "gzip"
    }

    $url = "https://api.elevenlabs.io/v1/text-to-speech/$vid"

    if ($FileMP3 -eq "")
    {
        Write-Host "Kein Dateiname für MP3-Datei angegeben - Abbruch" -ForegroundColor Red
        return
    }
    if (Test-Path $FileMP3)
    {
        $e = Read-Host "Datei $FileMP3 bereits vorhanden, überschreiben? (j/N)"
        if ($e -ne "J")
        {
            Write-Host "Abbruch" -ForegroundColor Red
            return
        }
        Remove-Item $FileMP3 -Force
    }
    Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $bodyJson -ContentType "application/json" -OutFile $FileMP3
}

function vimrem
{
    param(
        [parameter(position = 1, mandatory = $true)][string]$Path
    )
    $TempFile = [System.IO.Path]::GetTempFileName()

    copy-item -fromsession $Global:Session -path $Path -destination $TempFile

    vim $TempFile

    copy-item -tosession $Global:Session -path $TempFile -destination $Path

    remove-item -path $TempFile
}

. /Users/carstenschlegel/.local/share/powershell/Modules/Speech/speech.ps1

Set-Location $startpath

function musik {
    Write-Host "1. Sound of Silence (silence)"
    Write-Host "2. Valhalla Calling Me (val)"
    Write-Host "3. Hoist the Colours high (hoist)"
    Write-Host "4. Somewhere over the rainbow (rainbow)"
    $i = Read-Host
    if ($i -eq "1") { silence; }
    if ($i -eq "2") { val; }
    if ($i -eq "3") { hoist; }
    if ($i -eq "4") { rainbow; }  
}
function rainbow {
    ii "/Users/carstenschlegel/Music/rainbow.mp4"
    Start-Sleep -Seconds 5
    mvim -f /Users/carstenschlegel/rainbow
    Get-Process -Name VLC | Stop-Process
}

function silence {
    ii "/Users/carstenschlegel/Music/Sound of Silence.mp4"
    Start-Sleep -Seconds 5
    mvim -f /Users/carstenschlegel/soundofsilence
    Get-Process -Name VLC | Stop-Process
}
function val {
    ii "/Users/carstenschlegel/Music/VALHALLA CALLING by Miracle Of Sound ft. Peyton Parrish (Assassin's Creed) (DUET VERSION).mp4"
    Start-Sleep -Seconds 5
    mvim -f /Users/carstenschlegel/valhalla
    Get-Process -Name VLC | Stop-Process
}
function hoist {
    ii "/Users/carstenschlegel/Music/Hoist The Colours - Bass Singers.mp4"
    Start-Sleep -Seconds 5
    mvim -f /Users/carstenschlegel/hoist
    Get-Process -Name VLC | Stop-Process
}

function logs {
    param(
        [Switch] $Live
    )
    if ($Live) {
        ssh vm "docker logs -f mc"
    }
    else {
        ssh vm "docker logs mc"
    }
}

function ExitF { 
    if (Test-Path Env:/TMUX) {
        tmux detach
    }
    else {
        exit
    }
}
Set-Alias -Name ":q" -Value "ExitF"
Set-Alias -Name ":q!" -Value "ExitF"
Set-Alias -Name ":qa" -Value "eaf"
Set-Alias -Name ":qa!" -Value "eaf"

Set-Alias -Name "tmus" -Value "tmux"

Update-FormatData -PrependPath /Users/carstenschlegel/.config/powershell/format.ps1xml
Update-TypeData /Users/carstenschlegel/.config/powershell/types.ps1xml

Write-Host "Tools für Auflistung der PS-Tools"
Write-Host "Prozesse: stopgui [-NoRestart] | stopall" -ForegroundColor Red

$ENv:EDITOR="vim"

# Zeigt die Dateien von ~/Notizen an, außer es gibt keine Übereinstimmung dann alle Dateien (automatisch von PS so geregelt)
function VIM_ArgumentCompleter {
    param(
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )
 
    $posibleItems = @()
    $h = Resolve-Path ~
    $a = Resolve-Path .
    $testNotizen = ($h.Path -eq $a.Path)
    if (!$testNotizen) {
        return
    }

    $files = dir ~/Notizen
    $w =($Host.UI.RawUI.WindowSize.Width - 1) 
    $line = ("-")*($w) + "`n"
    foreach($f in $files) {
        $cc = @()
        $cc += (Get-Content $f | Select-Object -First 5)
        $cc += @("","","","","")
        $c = $cc | Select-Object -First 5
        if ($c[4] -eq "") {
            $c[4] = "´"
        }
        for($i = 0; $i -lt $c.Count;$i++) {

            if ($c[$i].Length -gt $w) {
                $c[$i] = $c[$i].SubString(0, $w)
            }
        }
        $item = [PSCustomObject]@{
            shortName = $f.Name
            longName = $f.Name
            toolTip = ($f | Out-String) + "$line$($c | Out-String)"
        }
        $posibleItems += $item
    }

    # Auswertung
    foreach($item in $posibleItems) {
        if ($item.shortName -match "^$($wordToComplete).*") {
            New-Object System.Management.Automation.CompletionResult (
                $item.shortName,
                $item.longName,
                "ParameterValue",
                $item.toolTip
            )
        }
    }
}

# Ersatz für VIM-Command, öffnet Dateien aus ~/Notizen oder .
# Kann Dateien als Array (x,y,z) oder Parameter (x y z) öffnen und öffent diese gleich in Tabs
#function vim {
#    param(
#        [ArgumentCompleter({VIM_ArgumentCompleter @args})]
#        $f = ""
#    )
#    $h = Resolve-Path ~
#    $a = Resolve-Path .
#    $testNotizen = ($h.Path -eq $a.Path)
#    if ($f -eq ".") {
#        nvim .
#        return
#    }
#
#    if ($args.Count -gt 0) {
#        $d = @()
#        $d += $f
#        $d += $args
#        $f = $d
#    }
#    if ($f -is [Object[]]) {
#        $arg = @()
#        foreach($file in $f) {
#            if ($file -ne "") {
#                if ((Test-Path "~/Notizen/$file") -and $testNotizen) {
#                    $arg += "~/Notizen/$file"
#                }
#                else {
#                    $files = Get-ChildItem $file -ErrorAction SilentlyContinue
#                    $filesh = Get-ChildItem $file -Hidden -ErrorAction SilentlyContinue
#                    $total = @()
#                    $total += $files.FullName
#                    $total += $filesh.FullName
#                    $total = $total | Where-Object { $_ -ne $null } | Select-Object -Unique
#                    $arg += $total
#                }
#            }
#        }
#        nvim $arg -p
#    }
#    else {
#        if ($f -eq "") {
#            nvim
#        }
#        elseif ((Test-Path "~/Notizen/$f") -and $testNotizen) {
#            nvim ("~/Notizen/$f")
#        }
#        else {
#            $files = Get-ChildItem $f -ErrorAction SilentlyContinue
#            $filesh = Get-ChildItem $f -Hidden -ErrorAction SilentlyContinue
#            $total = @()
#            $total += $files.FullName
#            $total += $filesh.FullName
#            $total = $total | Where-Object { $_ -ne $null } | Select-Object -Unique
#
#            if ($total.Count -eq 1) {
#                nvim $f
#            }
#            else {
#                if ($total.Count -gt 1) {
#                    nvim ($total) -p
#                }
#                else {
#                    nvim $f
#                }
#            }
#        }
#    }
#}

function vimrc {
    nvim +":NERDTreeToggle /Users/carstenschlegel/.config/nvim"
    }

# Suportis Crypto Script V -START-
# Suportis Crypto Script V -END-

function startz {
/Users/carstenschlegel/Coding/Sonstiges/tmux_scripts/tt.ps1
}

function nt {
    param(
    $msg,
    $topic = "test",
    [switch] $Ouput,
    [switch] $V
    )
    if ($V) {
        return "1.0";
    }
    $j = curl -d $msg  www.bugfrei.org:81/$topic
    if ($Outut) {
        return (ConvertFrom-Json $j)
    }
}

#SAPCodeGen:
Invoke-RestMethod https://raw.githubusercontent.com/bugfrei/SAPCodeGen/main/supacg.ps1 -OutVariable xxx | out-null; . ([scriptblock]::Create($xxx))

function DiffClip {
    [CmdletBinding()]
    [Alias("CompareClip", "ClipDiff", "ClipCompare")]
    param(
    )

    Read-Host "Code von Video"; Set-Content ~/1 (gcb) -Force;Read-Host "Code von Student";Set-Content ~/2 (gcb) -Force;tmux send-keys -t std:main.0 "vim -d 1 2" Enter;tmux select-pane -t std:main.0
}
function gitdiff {
    git diff ( [Regex]::Match( (git l | fzf), ".*([a-f0-9]{7,9})").Groups[1].Value )
}

$env:FZF_DEFAULT_OPTS="--no-sort --layout=reverse-list"

# TMUX Kürzel
function tn {
    $session = ([regex]::Match(  (Get-Location).Path, '.*/(.*)').Groups[1].Value)
    tmux new -s $session -d
    tmux switch -t $session
}

function tk {
    $session = ([regex]::Match(  (Get-Location).Path, '.*/(.*)').Groups[1].Value)
    tmux switch -n
    tmux kill-session -t $session
}

function keep-alive {
    [CmdletBinding()]
    [Alias("keep","keepalive")]
    param(
    )
    Write-Host "Keep Alive..."
    while($true) 
    {
        cliclick m:+5,+0
        start-sleep -Seconds 1
        cliclick m:-10,+0
        start-sleep -Seconds 60
    }
}

