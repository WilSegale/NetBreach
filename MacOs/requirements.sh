#!/bin/bash

# Source the file DontEdit.sh
source DontEdit.sh

# Wifi connection check function
WifiConnection() {
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Check if Homebrew is installed
        if command -v brew &> /dev/null; then
            installPackages
        else
            InstallHomeBrew
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
    fi
}

# Ethernet connection check function
EthernetConnection() {
    # Get the list of network interfaces
    interfaces=$(ifconfig)

    # Check if 'en0' or other common Ethernet interface is up
    if echo "${interfaces}" | grep -q "en0"; then
        # Check if 'en0' has an inet address
        inet=$(ifconfig en0 | grep "inet ")
        if [ -n "${inet}" ]; then
            # Check if Homebrew is installed
            if command -v brew &> /dev/null; then
                installPackages
            else
                InstallHomeBrew
            fi
        else
            echo -e "[ ${RED}FAIL${NC} ] Ethernet (en0) or WiFi is not connected."
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ] Ethernet (en0) or WiFi interface not found."
    fi
}

# Install Homebrew if not already installed
InstallHomeBrew() {
    
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
                echo "Run the program again to install the rest of the packages."
            fi
        elif [[ "${no[*]}" == *"${answer}"* ]]; then
            echo "Exiting the script."
        else
            echo "Exiting the script."
        fi
        exit 1
    fi
}

# Function to install package using brew package manager
install_brew_package() {
    package_name="$1"
    if ! brew list --formula | grep -q "^${package_name}\$"; then
        brew install "${package_name}"
        if [ $? -eq 0 ]; then
            echo -e "[ ${BRIGHT}${GREEN}OK${NC} ] ${package_name} installed and verified successfully."
        else
            echo -e "[ ${BRIGHT}${RED}ERROR${NC} ] ${package_name} installed but could not be imported in Python."
        fi
    else
        echo -e "[ ${BRIGHT}${GREEN}OK${NC} ] ${package_name} is already installed."
    fi
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
        echo -e "[ ${RED}ERROR${NC} ] Failed to install ${package_name}."
        exit 1
    fi
}

# Function to upgrade pip
upgrade_pip() {
    python3 -m pip install --upgrade pip --break-system-packages
}

# Check if packages are installed
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
            echo -e "${RED}${pipPackage}${NC}"
        done
        echo -e "________ERROR________"
        echo -e "${RED}Error occurred during pip uninstallation${NC}"
    else
        for package in "${Packages[@]}"
        do
            if brew list --formula | grep -q "^${package}\$"; then
                echo -e "${package}: ${GREEN}Is installed.${NC}"
            else
                echo -e "${package}: ${RED}not installed.${NC}"
            fi
        done
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}" 
        do
            echo -e "${pipPackage}: ${GREEN}Is Installed${NC}"
        done
    fi
}

# quits program with ctrl-c
EXIT_PROGRAM_WITH_CTRL_C() {
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# quits program with ctrl-z
EXIT_PROGRAM_WITH_CTRL_Z() {
    echo ""
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# Function to be executed when Ctrl+Z is pressed
handle_ctrl_z() {
    EXIT_PROGRAM_WITH_CTRL_Z
    exit 1
    # Your custom action goes here
}

# Set up the trap to call the function on SIGTSTP (Ctrl+Z)
trap 'handle_ctrl_z' SIGTSTP

# Function to handle Ctrl+C
ctrl_c() {
    echo ""
    EXIT_PROGRAM_WITH_CTRL_C
}

trap ctrl_c SIGINT

# Install packages function
installPackages() {
    # Check if the user is root
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

            # Install BREW packages
            echo ""
            echo "_________BREW PACKAGES INSTALLATION________"
            for package in "${Packages[@]}"; do
                install_brew_package "${package}"
            done

            # Install PIP packages
            echo ""
            echo "_________PIP PACKAGES INSTALLATION________"
            for PIP in "${pipPackages[@]}"; do
                install_pip_package "${PIP}"
            done

            # Update PIP
            echo ""
            echo "_________PIP UPDATES________"
            upgrade_pip

            # Check if the packages are installed
            echo ""
            echo "_________INSTALLED PACKAGES________"
            checkForPackages
        
        else
            echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
        fi
    fi
}

# Call EthernetConnection function
EthernetConnection

# Call InstallHomeBrew function
InstallHomeBrew