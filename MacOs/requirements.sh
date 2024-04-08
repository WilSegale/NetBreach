#!/bin/bash

# Source the file DontEdit.sh
source DontEdit.sh

RUN(){
    if command -v brew &>/dev/null; then
        echo
    else
        echo "Homebrew is not installed."
        echo
        echo "Would you like to install Homebrew? (YES/NO)"
        read -p ">>> " answer
        if [[ "${yes[*]}" == *"${answer}"* ]]; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            sleep 1
            eval "$(/opt/homebrew/bin/brew shellenv)"
            # Check the exit code of the previous command
            if [ $? -ne 0 ]; then
                echo -e "[ ${RED}FAIL${NC} ] Homebrew installation failed."
            else
                echo -e "[ ${GREEN}OK${NC} ] Homebrew installation successful."
            fi
        elif [[ "${no[*]}" == *"${answer}"* ]]; then
            echo "Exiting the script."
        else
            echo "Exiting the script."
        fi
        exit 1
    fi
}
RUN

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
if [ "$(id -u)" -eq 0 ]; then
    # Gives the user something to read so they understand why they got the error
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo "+   Don't use sudo for this script.     +"
    echo "+   Because it can damage your computer +"
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
# If the user is not root, exit the script
else
    # Check if the OS is Linux
    if [[ "${OSTYPE}" == "${OS}"* ]]; then
        if ping -c 1 google.com >/dev/null 2>&1; then

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

        else
            echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
    fi
fi