#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

uninstall_packages() {
    if [ "$(id -u)" -eq 0 ]; then
        title="ERROR"
        ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
        osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""

        figlet "ERROR"
        echo "Don't use sudo for this script."
        echo "Because it can damage your computer"
        exit 1
    else
        # Check if the OS is macOS
        if [[ "$OSTYPE" == "darwin"* ]]; then
            Packages=(
                "fcrackzip"
            )

            echo "_________BREW PACKAGES (TO UNINSTALL)________"

            uninstall_Brew_package() {
                package_name="$1"
                if command -v "${package_name}" >/dev/null 2>&1; then
                    echo "${package_name} is installed. Uninstalling..."
                    # Replace the following command with the appropriate package manager for your Linux distribution
                    brew uninstall "${package_name}"
                else
                    echo -e "${package_name} is not installed.${NC}"
                fi
            }

            # Uninstall BREW packages
            for package in "${Packages[@]}"; do
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
                if [ "$(id -u)" -eq 0 ]; then
                    title="ERROR"
                    ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
                    notify-send "$title" "$ERROR_MESSAGE"
                    
                    echo -e "${RED}ERROR:${NC} Don't use sudo for this script."
                    echo "Because it can damage your computer"
                    exit 1
                else
                    Packages=(
                        "fcrackzip"
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
                    for package in "${Packages[@]}"; do
                        uninstall_package "${package}"
                    done

                    echo
                    title="Packages"
                    ERROR_MESSAGE="All packages are uninstalled successfully"
                    notify-send "$title" "$ERROR_MESSAGE"
                    echo -e "${GREEN}All packages uninstalled.${NC}" # Add this line to indicate successful uninstallation
                fi
            else
                echo -e "${RED}ERROR:${NC} Unsupported operating system."
            fi
        fi
    fi
}
uninstall_packages