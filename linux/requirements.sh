#!/bin/bash
source DontEdit.sh

# Packages to install

requiredments() {
    # Check if the OS is Linux
    if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
        if ping -c 1 google.com >/dev/null 2>&1; then
            # Install package using apt package manager (replace with your distribution's package manager if needed)
            install_linux_package() {
                package_name="$1"
                if ! command -v "${package_name}" >/dev/null 2>&1; then
                    sudo apt-get install "${package_name}" -y
                else
                    echo -e "${package_name} is already ${GREEN}installed.${NC}"
                fi
            }

            # Install package using pip
            install_pip_package() {
                package_name="$1"
                if ! python3 -m pip show "${package_name}" >/dev/null 2>&1; then
                    pip3 install "${package_name}"
                else
                    echo -e "${package_name} is already ${GREEN}installed.${NC}"
                fi
            }

            echo
            echo "_________APT PACKAGES________"

            # Install APT packages
            for package in "${Packages[@]}"; do
                install_linux_package "${package}"
            done

            echo
            echo "_________PIP PACKAGES________"
            # Install PIP packages
            for PIP in "${pipPackages[@]}"; do
                install_pip_package "${PIP}"
            done

            echo

            # Update PIP
            echo "_________PIP UPDATES________"
            sudo python3 -m pip install --upgrade pip

            echo
            successful_MESSAGE="${GREEN}[+]${NC} All packages are installed successfully"
            echo -e "${successful_MESSAGE}"
        else
            echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
        fi
    else
        echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] Wrong OS, please use the correct OS." # If the user is not using the right OS, it says "You are using the wrong OS"
    fi
}

requiredments
