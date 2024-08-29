#!/usr/bin/bash

scriptDir=$(dirname "$(readlink -f "$0")")
file="$scriptDir/variables.txt"

currentTemplate=$(sed -n '1p' $file)

if [ $currentTemplate = "red" ]; then
    sed -i "1s/.*/blue/" "$file"
else
    sed -i "1s/.*/red/" "$file"
fi

sed -i "2s/.*/-1/" "$file"

bash "$scriptDir/wallpaperChanger.sh"