# Funktionsweise

Das Repo (bzw. der Ordner davon) muss 1 Ordner über Userhome sein


```
/Users/name/Stow
```

Dann in den Ordner wechseln

```
cd Stow
```

Mit `dir` auflisten welche Einstellungen exisiteren.

`Stow` installieren

`stow <ordnername>` installiert die in dem Ordner existierenden Konfigs als Link auf den Rechner.


# Updates

Einfach

```
git pull
(dir -dir).Name | ForEach-Object { stow $_ }
```

Updated alle Konfigs.

