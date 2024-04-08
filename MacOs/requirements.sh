#!/bin/bash

# Source the file DontEdit.sh
source DontEdit.sh


check_brew() {
    if command -v brew &>/dev/null; then
        echo "Homebrew is installed."
    else
        echo "Homebrew is not installed."
        echo "Would you like to install Homebrew? (YES/NO)"
        read -r install_brew
    fi
}

# Function to check if a package is installed
check_package() {
    if dpkg -s "$1" &> /dev/null; then
        echo "$1 is installed."
    else
        echo "$1 is not installed."
    fi
}

# Function to install package using brew package manager
install_brew_package() {
    package_name="$1"
    brew install "${package_name}"
    echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
}

# Function to install package using pip
install_pip_package() {
    package_name="$1"
    python3 -m pip install --user --upgrade "${package_name}" --break-system-packages
    echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
}

# Function to upgrade pip
upgrade_pip() {
    python3 -m pip install --upgrade pip --break-system-packages
    echo -e "[ ${GREEN}OK${NC} ] pip packages updated successfully."
}

# Check if the OS is Linux
if [[ "${OSTYPE}" == "${OS}"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Perform package checks
        echo "_________PACKAGE CHECKS________"
        for package in "${packages[@]}"; do
            check_package "$package"
        done

        # Install BREW packages
        echo ""
        echo "_________BREW PACKAGES INSTALLATION________"
        for package in "${Packages[@]}"; do
            install_brew_package "${package}"
        done

        echo ""
        echo "_________PIP PACKAGES INSTALLATION________"
        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        # Update PIP
        echo ""
        echo "_________PIP UPDATES________"
        upgrade_pip

        echo "All packages installed successfully."

    else
        echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
