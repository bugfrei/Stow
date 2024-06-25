# Um dieses Profile auch im VSC nutzen zu können, muss es in der Profile-Datei von VSC reinkopiert werden
# = als Platzhalter für Measure-Object
Set-Alias -Name "=" -Value "Measure-Object"
New-Alias -Name term -Value zsh
New-Alias -Name vim -Value nvim
New-Alias -Name typem -Value "Show-Markdown"
New-Alias -Name lsa -Value dir
New-Alias -Name py -Value python3
New-PSDrive -Name C -PSProvider FileSystem -Root /
New-PSDrive -Name G -PSProvider FileSystem -Root /Users/carstenschlegel/temp

# Variablen
$username = [System.Environment]::Username
$icloud = "/Users/$username/Library/Mobile Documents"

$vimrc = "/Users/$username/.config/nvim/init.vim"
$viminst = "/usr/share/vim/vim90"
$gitcfg = "/Users/$username/.gitconfig"
$mod = "/Users/$username/.local/share/powershell/Modules"
$global:__VSCodeOriginalPrompt = "x"
$temp = "/Users/$username/temp"
$dl = "/Users/$username/downloads"
$dok = "/Users/$username/documents"

# Aliase für folgende Cmdlets laden
$WarningPreference = "SilentlyContinue"
Import-Module -Name Path | Out-Null
Import-Module -Name TranslateSearch | Out-Null
Import-Module -Name Commands | Out-Null
Import-Module -Name sup | Out-Null
# /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -Silent
Import-Module -Name githelper | Out-Null
Import-Module -Name Helper | Out-Null
$WarningPreference = "Continue"

# UTF8 als Standard Encoding für Get-Content (type) und Out-File
$PSDefaultParameterValues = @{'Get-Content:Encoding' = 'utf8'; 'Out-File:Encoding' = 'utf8' }

# Ausgabe von Informationen
function info {
    param(
        [Switch] $nocls
    )
    if (-not $nocls) {
        cls
    }
    Write-Host "YouTube (y), Bing (b), Google (g), Get-English (en), Get-German (de), Start-Search (suche), Projekt" -ForeGroundColor Red
    Write-Host "ts, js, sap (TypeScript, JavaScript, SAP)" -ForegroundColor Gray
    Write-Host "vim `$profile, vim `$vimrc, vim `$gitcfg" -ForegroundColor Gray
    Write-Host "Compress-Archive <files> <archivename.zip>  |  Expand-Archive <archivename.zip> <destPath>" -ForegroundColor Yellow
    Write-Host "c (code .), cw (work) für VS Code Workspaces" -ForegroundColor Red
    Write-Host "url [copy|open] für Github-Repository URL" -ForegroundColor Yellow 
    Write-Host "vh (vim, multiple files in tabs + help)" -ForegroundColor Yellow 
    Write-Host "" -ForegroundColor Yellow 
    Write-Host
}
#Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
Set-PSReadLineKeyHandler -Key ' ,y' -Function Copy -ViMode Command
Set-PSReadLineKeyHandler -Key ' ,p' -Function Paste -ViMode Command
# Ermöglicht Strg+N als Ersatz für Strg+Space (Verfollständigung) in Visual Studio Code
Set-PSReadLineKeyHandler -Chord 'F5' -ViMode Command -ScriptBlock { . /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -nocls; Write-Host "Fertig"; [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); } -BriefDescription "Lädt das SUP Script neu"
Set-PSReadLineKeyHandler -Chord 'F5' -ViMode Insert -ScriptBlock { . /Users/carstenschlegel/.local/share/powershell/Modules/sup/sup.ps1 -nocls; Write-Host "Fertig"; [Microsoft.PowerShell.PSConsoleReadLine]::UndoAll(); [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); } -BriefDescription "Lädt das SUP Script neu"
Set-PSReadLineKeyHandler -Key ' ,a' -ViMode Command -Function SelectAll
Set-PSReadLineKeyHandler -Key ' ,h' -ViMode Command -Function ShowKeyBindings
Set-PSReadLineKeyHandler -Key ' ,k' -ViMode Command -Function WhatIsKey
Set-PSReadLineKeyHandler -ViMode Insert -Function MenuComplete -Chord "Ctrl+n"
Set-PSReadLineKeyHandler -Function MenuComplete -ViMode Insert  -Chord "Tab"


function FindRootLabel {
    param(
        [Switch] $returnPath
    )
    $f = (Get-Location).Path
    while ($f -ne "") {
        if (Test-Path (Join-Path $f "dir.label")) {
            if ($returnPath) {
                $p = (Split-Path (Join-Path $f "dir.label") -Resolve)
                $p = $p.replace("\", "/")
                return $p
            }
            return $true
        }
        $f = (Split-Path $f -Parent)
    }
    return $false
}
function FindGoGit {
    param(
        [Switch] $returnPath
    )
    $f = (Get-Location).Path
    while ($f -ne "") {
        if (Test-Path (Join-Path $f ".git")) {
            if ($returnPath) {
                $p = (Split-Path (Join-Path $f ".git") -Resolve)
                $p = $p.replace("\", "/")
                return $p
            }
            return $true
        }
        $f = (Split-Path $f -Parent)
    }
    return $false
}

function prompt {
    $esc = ([char]0x1b)
    
    $loc = (Get-Location).Path

    $labelFound = $false
    if ((Get-Location).Path -eq (Get-Item "~").FullName) {
        $loc = " ~"
    }
    if (Test-Path "dir.label") {
        $loc = (Get-Content "dir.label")
        $labelFound = $true
    }
    if (-not $labelFound) {
        if (FindRootLabel) {
            $gp = (FindRootLabel -returnPath)
            if (Test-Path (Join-Path $gp "dir.label")) {
                $grLabel = (Get-Content (Join-Path $gp "dir.label"))
                $loc = $loc.Replace($gp, $grLabel.Trim())
            }
        }
    }
    if (FindGoGit) {
        
        $s = (Git status)
        $branch = ""
        $back = ""
        foreach ($l in $s) {
            if ($l.StartsWith("Auf Branch")) {
                $branch = $l.Replace("Auf Branch", "").Trim()
            }
            elseif ($l.StartsWith("On brnach")) {
                $branch = $l.Replace("On branch", "").Trim()
            }
            # TODO Englische Version des Matches
            $r = [regex]::Match($l, "^Ihr Branch ist (\d*) Commits")
            if ($r.Groups.Count -gt 1) {
                $back = "⇡$($r.Groups[1].Value)"
            }
        }
        if ($branch -eq "") {
            $branch = " 🤖‼️ "
        }
        $neu = 0
        $mod = 0
        $son = 0
        $staged = 0
        $s = (Git status -s)
        foreach ($l in $s) {
            $l = $l.Trim()
            if ($l.StartsWith("M")) {
                $mod++
            }
            elseif ($l.StartsWith("??")) {
                $neu++
            }
            elseif ($l.StartsWith("A")) {
                $staged++
            }
            else {
                $son++
            }
        }
        if ($mod -gt 0) {
            $mod = "✎$($mod) "
        }
        else {
            $mod = ""
        }
        if ($neu -gt 0) {
            $neu = "+$($neu) "
        }
        else {
            $neu = ""
        }
        if ($staged -gt 0) {
            $staged = "📥$($staged) "
        }
        else {
            $staged = ""
        }
        if ($son -gt 0) {
            $son = ".$($son) "
        }
        else {
            $son = ""
        }
        $info = ($mod + $neu + $staged + $son).Trim()
        if ($info -ne "") { 
            $info = " $info"
        }
        if ($back -ne "") {
            $back = " $back"
        }

        Write-Host "$esc[38;5;0;48;5;7m $esc[38;5;7;42m $esc[38;5;0;42m  $branch$back$info$esc[32;44m $esc[38;5;15;44m$loc$esc[34;48;5;234m$esc[0m" -NoNewline

    }
    else {
        Write-Host " $esc[38;5;15;44m$loc$esc[34;48;5;234m$esc[0m" -NoNewline
    }

    return " "
}

cd ~

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

