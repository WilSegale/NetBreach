#!/bin/bash

# Source the file DontEdit.sh
source DontEdit.sh

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
            echo -e "${RED}${pipPackage}${NC}"
        done
        echo -e "________ERROR________"
        echo -e "${RED}Error occurred during pip uninstallation${NC}"
    else
        for package in "${Packages[@]}"
        do
            if brew list --formula | grep -q "^${package}\$"; then
                echo -e "${package} is ${GREEN}installed.${NC}"
            else
                echo "${package} is ${RED}not installed.${NC}"
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
EXIT_PROGRAM_WITH_CTRL_Z(){
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

InstallHomeBrew(){
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

# Call the function
InstallHomeBrew

# Function to install package using brew package manager
install_brew_package() {
    package_name="$1"
    brew install "${package_name}"
}

# Function to install package using pip
install_pip_package() {
    package_name="$1"
    python3 -m pip install --user --upgrade "${package_name}" --break-system-packages
}

# Function to upgrade pip
upgrade_pip() {
    python3 -m pip install --upgrade pip --break-system-packages
}

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
        if ping -c 1 google.com >/dev/null 2>&1; then

            # Install BREW packages
            echo ""
            echo "_________BREW PACKAGES INSTALLATION________"
            for package in "${Packages[@]}"; do
                install_brew_package "${package}"
            done

            # install pip packages
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

            # Check if the packages are installed
            echo ""
            echo "_________INSTALLED PACKAGES________"
            checkForPackages
        else
            echo -e "[ ${RED}FAIL${NC} ] NOT CONNECTED TO THE INTERNET"
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
    fi
fi