#!/bin/bash
source DontEdit.sh


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
echo -e "doing a ${GREEN}dpkg configure${NC}"

sudo dpkg --configure -a

#checks if the user has pakcages installed or not
checkForPackages() {
    if [ $? -ne 0 ]; then
        for package in "${Packages[@]}" 
        do
            echo -e "The packages that are installed are: ${package}"
        done
        echo ""
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}" 
        do
            echo -e "${BRIGHT{{RED}${pipPackage}${NC}"
        done
        echo -e "________ERROR________"
        echo -e "${BRIGHT}${RED}Error occurred during pip uninstallation${NC}"
    else
        for package in "${Packages[@]}"
        do
            if dpkg -l | grep -q "^ii  ${package} "; then
                echo -e "${package} is ${BRIGHT}${GREEN}installed${NC}"
            else
                echo -e "${package} is ${BRIGHT}${RED}NOT installed${NC}"
            fi
        done
        echo ""
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}" 
        do
            if pip show "${pipPackage}" > /dev/null 2>&1; then
                echo -e "${pipPackage} is ${GREEN}installed${NC}"
            else 
                echo -e "${pipPackage} is ${RED}NOT installed${NC}"
            fi 
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
            echo -e "[ ${BRIGHT}${GREEN}OK${NC} ] ${package_name} installed successfully."
        }

        # Function to install package using pip
        install_pip_package() {
            package_name="$1"
            
            # Attempt to install the package
            python3 -m pip install --user --upgrade "${package_name}" --break-system-packages
            
            # Check the exit code of the installation
            if [ $? -eq 0 ]; then
                # Verify the package installation by trying to import it in Python
                python3 -c "import ${package_name}" 2>/dev/null
                
                if [ $? -eq 0 ]; then
                    echo -e "[ ${BRIGHT}${GREEN}OK${NC} ] ${package_name} installed and verified successfully."
                else
                    echo -e "[ ${BRIGHT}${RED}ERROR${NC} ] ${package_name} installed but could not be imported in Python."
                    exit 1
                fi
            else
                echo -e "[ ${BRIGHT}${RED}ERROR${NC} ] Failed to install ${package_name}."
                exit 1
            fi
        }

        # Function to upgrade pip
        upgrade_pip() {
            python3 -m pip install --upgrade pip
            echo -e "[ ${BRIGHT}${GREEN}OK${NC} ] pip packages updated successfully."
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
        echo "_________APT PDPACKAGES________"
        checkForPackages

    else
        echo -e "[ ${BRIGHT}${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${BRIGHT}${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
}
requiredments