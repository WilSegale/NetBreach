#!/bin/bash
source DontEdit.sh

echo -e "doing a ${GREEN}dpkg configure${NC}"

sudo dpkg --configure -a
# Check if the OS is Linux
if [[ "${OSTYPE}" != "linux-gnu" ]]; then
    echo "This script only works on Linux."
    exit 1
fi

# Check if the user is root
if [[ "${EUID}" -ne 0 ]]; then
    echo "Please run this script as root."
    exit 1
fi

echo "Running as root."
echo ""
echo "Installing packages..."
echo ""
# Install APT packages

#checks if the user has pakcages installed or not
checkForPackages() {
    if [ $? -ne 0 ]; then
        for package in "${Packages[@]}" 
        do
            echo -e "The packages that are installed are: ${package}"
        done
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}" 
        do
            echo -e "${RED}${pipPackage}${NC}"
        done
        echo -e "________ERROR________"
        echo -e "${RED}Error occurred during pip uninstallation${NC}"
    else
        for package in "${Packages[@]}"
        do
            echo -e "${package}: ${GREEN}Is Installed${NC}"
        done
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}" 
        do
            echo -e "${pipPackage}: ${GREEN}Is Installed${NC}"
        done
    fi
}





requiredments(){
# Check if the OS is Linux
if [[ "${OSTYPE}" == "${Linux}"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Function to install package using apt package manager
        install_linux_package() {
            package_name="$1"
            sudo apt-get install "${package_name}" -y
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Function to install package using pip
        install_pip_package() {
            package_name="$1"
            python3 -m pip install --user --upgrade "${package_name}"
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Function to upgrade pip
        upgrade_pip() {
            python3 -m pip install --upgrade pip
            echo -e "[ ${GREEN}OK${NC} ] pip packages updated successfully."
        }

        # Install APT packages
        for package in "${Packages[@]}"; do
            install_linux_package "${package}"
        done

        echo ""
        echo "_________PIP PACKAGES________"
        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        # Update PIP
        echo ""
        echo "_________PIP UPDATES________"
        upgrade_pip
        
        echo ""
        echo "_________INSTALLED PACKAGES________"
        checkForPackages

    else
        echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
}
requiredments