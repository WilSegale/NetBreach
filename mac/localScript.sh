#!/bin/bash

#holds the file that contains importent funcitons for the porgram to work
source DontEdit.sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to handle cleanup on exit
cleanup() {
    echo -e "${RED}[-]${NC} EXITING SOFTWARE..."
    # Add cleanup commands here
    exit 1
}

# Function to handle Ctrl+C
ctrl_c() {
    echo ""
    cleanup
}

trap ctrl_c SIGINT

# Check for required packages
for package in "${required_packages[@]}"; do
    if ! command_exists "$package"; then
        echo -e "ERROR: The required package ${GREEN}'$package'${NC} is not installed. Please install it and try again."
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
    if [[ "$OSTYPE" == "${OS}"* ]]; then
        # Clear the terminal
        clear

        # Tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
        LocalHercules() {
            # The logo of the program
            figlet -f slant "Hercules"
            echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'"
            echo "If you want to stop the program type 'stop'."
            read -p ">>> " service
            
            if [[ $service == "ALL" || $service == "all" ]]; then
                # Scan the entire network and display open ports
                nmap 127.0.0.1 --system-dns -Pn -oN local.txt
                hydra -h
                echo "Put in Hydra first to start the script."
                echo ""
                read -p ">>> " Hydra

                if [[ " ${exit[*]} " == *" ${Hydra} "* ]]; then
                    echo "[+] Goodbye"
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
            #checks if the user has put in a letter insed of a number into the input feild
            elif [[ " ${alphabet[*]} " == *" ${service} "* ]]; then
                echo "Please enter a number next time"
                exit 1

            else
                # Scan specific port
                nmap 127.0.0.1 --system-dns -p $service
            fi
        }

        LocalRunHackingCommand() {
            # Break in the outputs of my code
            echo
            original_host=127.0.0.1
            original_port=$service

            # Check if the port is closed
            if nc -zv "$original_host" "$original_port" >/dev/null 2>&1; then
                echo ""
            else
                echo -e "${RED}[-]${NC} Port $original_port on $original_host is closed."
                # Optionally, you can choose to exit or handle closed port differently
                exit 1
            fi

            # Services to crack the network
            echo "To crack VNC(5900), don't type anything in the 'Input Username' prompt"
            echo "To crack MySQL(3306), type 'localhost' in the 'Input Hostname' prompt"
            echo $username@$hostname

            # Use different variables for user input to avoid overwriting original host and port
            read -p "Input Username: " user_input
            read -p "Input Hostname: " host_input

            # Use user input or fallback to original values if user input is empty
            user=${user_input:-$user}
            host=${host_input:-$original_host}
        }

        LocalRunHackingCommandWithVNC() {

            if [[ $service == 5900 || $service == "VNC" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    LocalHercules
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else
                    # Crack VNC password
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
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

        LocalRunHackingCommandWithSSH() {
            if [[ $service == 22 || $service == "ssh" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    LocalHercules
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else
                    # Crack SSH password
                    hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                    # Alerts the user that the computer is trying to connect to the ssh server
                    title="Connecting to ${user}"
                    Connecting_To_SSH_SERVER="We are connecting you to ${user}. Please wait..."
                    echo "${title}"
                    echo "${Connecting_To_SSH_SERVER}"
                    sleep 5

                    # It connects to the ssh server and asks for the user to input a password to connect to the ssh server
                    echo
                    title="Enter password to ${user}"
                    Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
                    echo "${title}"
                    echo "${Connected_To_SSH_SERVER}"
                    ssh "${user}@${host}"
                fi
            fi
        }

        LocalRunHackingCommandWithMySQL() {
            if [[ $service == 3306 || $service == "mysql" ]]; then
                # Checks if the user has put anything in the 'Input Username' function and the hostname function
                # If not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    LocalHercules
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

        LocalHercules # Calls the Hercules function

        LocalRunHackingCommand # Calls the RunHackingCommand function

        LocalRunHackingCommandWithVNC # Calls the RunHackingCommandWithVNC function

        LocalRunHackingCommandWithSSH # Calls the RunHackingCommandWithSSH function

        LocalRunHackingCommandWithMySQL # Calls the RunHackingCommandWithMySQL function
    else
        clear
        # Warning message for wrong OS
        echo "WARNING:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo "TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
    fi
fi