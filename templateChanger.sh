#!/usr/bin/bash

profileUUID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

redPalette="['#171421', '#c01c28', '#c01c28', '#a2734c', '#12488b', '#a347ba', '#2aa1b3', '#d0cfcc', '#5e5c64', '#f66151', '#33d17a', '#e9ad0c', '#2a7bde', '#c061cb', '#33c7de', '#ffffff']"
bluePalette="['#171421', '#12488b', '#c01c28', '#a2734c', '#12488b', '#a347ba', '#2aa1b3', '#d0cfcc', '#5e5c64', '#f66151', '#33d17a', '#e9ad0c', '#2a7bde', '#c061cb', '#33c7de', '#ffffff']"

scriptDir=$(dirname "$(readlink -f "$0")")
file="$scriptDir/variables.txt"

currentTemplate=$(sed -n '1p' $file)

if [ $currentTemplate = "red" ]; then
    sed -i "1s/.*/blue/" "$file"
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileUUID/" bold-color "#12488b"
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileUUID/" palette "$bluePalette"
else
    sed -i "1s/.*/red/" "$file"
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileUUID/" bold-color "#C01C28"
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileUUID/" palette "$redPalette"
fi

sed -i "2s/.*/-1/" "$file"

bash "$scriptDir/wallpaperChanger.sh"