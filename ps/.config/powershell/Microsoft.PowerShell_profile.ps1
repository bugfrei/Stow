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

