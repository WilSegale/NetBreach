#!/bin/bash
source DontEdit.sh
# Get the list of installed packages and store them in an array
# Loop through each package and check if it is installed
for package in "${Packages[@]}"; do
    if dpkg -l | grep -q "^ii  ${package} "; then
        package_name="$1"
        apt list $package_name --installed
    else
        echo "${package} is NOT installed"
    fi
done