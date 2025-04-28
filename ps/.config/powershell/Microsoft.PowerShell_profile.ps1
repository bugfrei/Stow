# UPDATE STOW REPO (nur Montags)
if ([DateTime]::Now.DayOfWeek -eq [System.DayOfWeek]::Monday) {
    cd ~/stowdir
    git add .
    git commit -m "Aktuelle Version"
    git push
    cd ~
}

