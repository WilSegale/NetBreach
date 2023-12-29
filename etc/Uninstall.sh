#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check root privileges
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}ERROR:${NC} Don't use sudo or run as root for this script. Exiting..."
    exit 1
fi

uninstall_packages() {
    # Check if the OS is macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Packages to remove
        packages=("fcrackzip"
                "figlet"
                "ffmpeg"
                "jq"
        )

        echo "_________BREW PACKAGES (TO UNINSTALL)________"

        uninstall_Brew_package() {
            package_name="$1"
            if command -v "${package_name}" >/dev/null 2>&1; then
                echo "${package_name} is installed. Uninstalling..."
                brew uninstall "${package_name}"
            else
                echo -e "${package_name} is not installed.${NC}"
            fi
        }

        # Uninstall BREW packages
        for package in "${packages[@]}"; do
            uninstall_Brew_package "${package}"
        done

        echo
        title="Packages"
        ERROR_MESSAGE="All packages are uninstalled successfully"
        osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""
        echo -e "${GREEN}All packages uninstalled.${NC}" # Add this line to indicate successful uninstallation
    else
        # Check if the OS is Linux
        if [[ "$OSTYPE" == "linux"* ]]; then
            packages=("fcrackzip"
                    "figlet"
                    "ffmpeg"
                    "jq"
            )

            echo "_________APT PACKAGES (TO UNINSTALL)________"

            uninstall_package() {
                package_name="$1"
                if dpkg -l | grep -q "${package_name}"; then
                    echo "${package_name} is installed. Uninstalling..."
                    sudo apt-get purge -y "${package_name}"
                else
                    echo -e "${package_name} is not installed.${NC}"
                fi
            }

            # Uninstall APT packages
            for package in "${packages[@]}"; do
                uninstall_package "${package}"
            done

            echo
            title="Packages"
            ERROR_MESSAGE="All packages are uninstalled successfully"
            notify-send "$title" "$ERROR_MESSAGE"
            echo -e "${GREEN}All packages uninstalled.${NC}" # Add this line to indicate successful uninstallation
        else
            echo -e "${RED}ERROR:${NC} Unsupported operating system."
        fi
    fi
}

# Call the uninstall_packages function
uninstall_packages
