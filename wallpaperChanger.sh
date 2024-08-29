#!/usr/bin/bash

scriptDir=$(dirname "$(readlink -f "$0")")
file="$scriptDir/variables.txt"
currentTemplate=$(sed -n '1p' $file)

parent_process=$(ps -o comm= $PPID)

if [[ "$parent_process" == "systemd" ]]; then
    initialUri="file:///$scriptDir/$currentTemplate/wp0"
    gsettings set org.gnome.desktop.background picture-uri-dark "$initialUri"
else
    wall="/$currentTemplate/wp1"
    whole="$scriptDir$wall"
    uri="file:///$whole"

    gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
    echo $parent_process
fi