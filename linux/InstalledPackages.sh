#!/bin/bash
source DontEdit.sh
# Get the list of installed packages and store them in an array
# Loop through each package and check if it is installed
for package in "${packages[@]}"; do
    if dpkg -l | grep -q "^ii  $package "; then
        echo "$package is installed"
    else
        echo "$package is NOT installed"
    fi
done