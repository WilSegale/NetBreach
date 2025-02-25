#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[33m'
NC='\033[0m' # No Color

# Ensure DontEdit.sh exists
if [[ ! -f "DontEdit.sh" ]]; then
    echo -e "${RED}Error: DontEdit.sh not found!${NC}"
    exit 1
fi

# Load the package list
source DontEdit.sh

# Arrays to store package statuses
ok_packages=()
fail_packages=()

echo "_________SYSTEM PACKAGES CHECK_________"

# Check installed system packages
for package in "${Packages[@]}"; do
    if dpkg -l | grep -q "^ii  ${package} "; then
        ok_packages+=("${GREEN}[ OK ]${NC} $package")
    else
        fail_packages+=("${RED}[ FAIL ]${NC} $package")
    fi
done

# Print system package results
printf "%s\n" "${ok_packages[@]}"
printf "%s\n" "${fail_packages[@]}"

echo -e "_________PIP PACKAGES CHECK_________"

# Reset status arrays
ok_packages=()
fail_packages=()

# Check installed pip packages
for pipPackage in "${pipPackages[@]}"; do
    if python3 -c "import ${pipPackage}" &>/dev/null; then
        ok_packages+=("${GREEN}[ OK ]${NC} $pipPackage")
    else
        fail_packages+=("${RED}[ FAIL ]${NC} $pipPackage")
    fi
done

# Print pip package results
printf "%s\n" "${ok_packages[@]}"
printf "%s\n" "${fail_packages[@]}"