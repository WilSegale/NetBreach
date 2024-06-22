#!/bin/bash
source DontEdit.sh
# Get the list of installed packages and store them in an array
packages=($(dpkg-query -W -f='${binary:Package}\n'))

# Print the array elements (package names)
for package in "${packages[@]}"; do
    echo "${package}"
done