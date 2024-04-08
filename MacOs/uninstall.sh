#!/bin/bash
source DontEdit.sh

# Function to handle cleanup on exit
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

# Checks if the user is ROOT and if they are, it prompts them not to use sudo
if [ "$(id -u)" -eq 0 ]; then
    # Puts the ERROR message into line art
    echo -e "${RED}$(figlet ERROR)${NC}"

    # Gives the user something to read so they understand why they got the error
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo "+   Don't use sudo for this script.     +"
    echo "+   Because it can damage your computer +"
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
else
    if [[ "${OSTYPE}" == "darwin"* ]]; then

        echo -e "${RED}${BRIGHT}!Are you sure you want to remove your Packages (YES/NO)!: ${NC}"

        read -p ">>> " YES_NO

        if [[ "${yes[*]}" == *"${YES_NO}"* ]]; then
            # Packages to check for installation
            Packages=(
                "wget"
                "hydra"
                "nmap"
                "mysql"
                "figlet"
                "zenity"
            )

            # PIP packages that will be uninstalled if they are installed
            pipPackages=(
                "asyncio"
                "pyfiglet"
            )
            check_brew() {
                # Check the exit code of the previous command
                if [ $? -ne 1 ]; then
                    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
                else
                    echo "Homebrew is not installed."
                fi
            }
            check_brew
             
            # Function to check and uninstall a package
            check_package() {
                package_name="$1"
                if command -v "${package_name}" >/dev/null 2>&1; then
                    echo "${package_name} is installed."
                    brew uninstall "${package_name}"
                else
                    echo -e "${RED}${package_name}${NC} Is not installed."
                fi
            }

            # Check packages
            for package in "${Packages[@]}"
            do
                check_package "${package}"
            done

            # Uninstall PIP packages
            for pipPackage in "${pipPackages[@]}"
            do
                if python3 -m pip show "${pipPackage}" >/dev/null 2>&1; then
                    pip3 uninstall "${pipPackage}" -y --break-system-packages

                    # Check the exit status of the last command
                    if [ $? -ne 0 ]; then
                        echo -e "Error occurred during uninstallation of \"${pipPackage}\""
                        exit 1
                    else
                        echo -e "${pipPackage}: uninstalled ${GREEN}successfully${NC}"
                    fi
                else
                    echo -e "${RED}${pipPackage}${NC}: Is not installed"
                fi
            done

            # Check the exit status of the last command
            if [ $? -ne 0 ]; then
                for package in "${Packages[@]}" 
                do
                    echo -e "The packages that are removed are: ${package}"
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
                    echo -e "${package}: ${RED}Is removed${NC}"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}" 
                do
                    echo -e "${pipPackage}: ${RED}Is removed${NC}"
                done
            fi

        elif [[ "${no[*]}" == *"$YES_NO"* ]]; then
            echo -e "${RED}${BRIGHT}Ok, I will not remove the packages.${NC}"
            exit 1
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ]This script can only be run on macOS"
    fi
fi