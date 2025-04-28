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

