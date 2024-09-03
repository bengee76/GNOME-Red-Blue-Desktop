#! /usr/bin/bash
#!!! add neofetch install !!!
#!!! change permissions !!!

doNames() {
    cd "$1" || exit

    count=0
    for file in *; do
        newName="wp$count"
        if [ "$file" != "$newName" ]; then
            mv "$file" "$newName"
        fi
        ((count++))
    done

    cd ".."
    ((count--))
    sed -i "${2}s/.*/${count}/" "$current"
}

currentDir=$(pwd)

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Change template"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "bash $currentDir/templateChanger.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Ctrl><Alt>r"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Change wallpaper"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "bash $currentDir/wallpaperChanger.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Ctrl><Alt>t"

current="variables.txt"

if [ -f "$current" ]; then
    echo "File '$current' exists."
else
    touch "$current"
fi

sed -i "1s/.*/red/" "$current"
sed -i "2s/.*/-1/" "$current"
doNames "red" 3
doNames "blue" 4

bash "wallpaperChanger.sh"