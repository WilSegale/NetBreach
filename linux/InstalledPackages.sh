#!/bin/bash
source DontEdit.sh
# Get the list of installed packages and store them in an array
# Loop through each package and check if it is installed
if dpkg -l | grep -q "^ii  $Packages "; then
    echo "$Packages is installed"
else
    echo "$Packages is NOT installed"
fi