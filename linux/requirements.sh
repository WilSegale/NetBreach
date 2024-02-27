#!/bin/bash
source DontEdit.sh

# Packages to install
Packages=(
    "curl"
    "wget"
    "hydra"
    "nmap"
    "mysql"
    "figlet"
    "zenity"
    "tigervnc-viewer"
)

pipPackages=(
    "asyncio"
    "pyfiglet"
)

requiredments() {
    # Check if the OS is Linux
    if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
        if ping -c 1 google.com >/dev/null 2>&1; then
            # Install package using apt package manager (replace with your distribution's package manager if needed)
            install_linux_package() {
                package_name="$1"
                if ! command -v "${package_name}" >/dev/null 2>&1; then
                    sudo apt-get install -y "${package_name}"
                else
                    echo -e "${package_name} is already \e[92minstalled.\e[0m"
                fi
            }

            # Install package using pip
            install_pip_package() {
                package_name="$1"
                if ! python3 -m pip show "${package_name}" >/dev/null 2>&1; then
                    pip3 install "${package_name}"
                else
                    echo -e "${package_name} is already \e[92minstalled.\e[0m"
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
            successful_MESSAGE="\e[92m[+]\e[0m All packages are installed successfully"
            echo -e "${successful_MESSAGE}"
        else
            echo -e "\e[91m\e[1mERROR:\e[0m NOT CONNECTED TO THE INTERNET"
        fi
    else
        echo -e "\e[91m\e[1m[-]\e[0m Wrong OS, please use the correct OS." # If the user is not using the right OS, it says "You are using the wrong OS"
    fi
}

requiredments
