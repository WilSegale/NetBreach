#!/bin/bash
# Load packages from DontEdit.sh if it exists
if [ -f "DontEdit.sh" ]; then
    source DontEdit.sh
else
    echo -e "[ ${RED}ERROR${NC} ] DontEdit.sh not found!"
    exit 1
fi

# Arrays to store results
ok_packages=()
fail_packages=()

# Check each package
for package in "${Packages[@]}"; do
    if dpkg -l | grep -q "^ii  ${package} "; then
        ok_packages+=("[ ${GREEN}OK${NC} ] ${package}")
    else
        fail_packages+=("[ ${RED}FAIL${NC} ] ${package}")
    fi
done

# Display results with FAIL at the bottom
echo "_________PACKAGE STATUS________"
for ok in "${ok_packages[@]}"; do
    echo -e "${ok}"
done
for fail in "${fail_packages[@]}"; do
    echo -e "${fail}"
done