#!/usr/bin/bash

scriptDir=$(dirname "$(readlink -f "$0")")
file="$scriptDir/variables.txt"
currentTemplate=$(sed -n '1p' $file)
currentWall=$(sed -n '2p' $file)

if [ $currentTemplate = "red" ]; then
    wallNum=$(sed -n '3p' $file)
else
    wallNum=$(sed -n '4p' $file)
fi
    
if [ $currentWall -eq $wallNum ]; then
    currentWall=0
else
    ((currentWall++))
fi

sed -i "2s/.*/${currentWall}/" "$file"

wall="/$currentTemplate/wp$currentWall"
whole="$scriptDir$wall"
uri="file:///$whole"

gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
echo "done"