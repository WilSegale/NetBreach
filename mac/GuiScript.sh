#!/bin/bash

#url to see if the user is connected to the internet
SITE="https://google.com/"

# Root user
root=0

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# checks if the user is in root mode or not
if [[ $EUID -ne $root ]]; then
    title="NOT ROOT"
    message="TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}"
    # Error message if not running as root
    echo "ERROR:root:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
    
    zenity --error --title="${title}" --text="${message}"
    exit
else
    # Try to connect to the server
    wget -q --spider "${SITE}"
    
    # If the user is connected to the internet, it works as normal
    if [[ $? -eq 0 ]]; then
        clear
    # Else, it notifies them that they are not connected to the internet and tells them to connect
    else
        offlineTitle="offline"
        offline="TIME:${CURRENT_TIME} You are offline. Please connect to the internet. DATE:${CURRENT_DATE}"
        zenity --warning --title="${offlineTitle}" --text="${offline}"
        exit 1
    fi
    clear

    Hercules(){
        # Display the program logo using figlet
        logo_text=$(figlet -f slant "Hercules")

        # Display a message explaining the options
        options_text="Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'\nIf you want to stop the program, type 'stop'."

        # Show an entry dialog to get user input
        service=$(zenity --entry --title "Hercules" --text "$logo_text\n$options_text" --entry-text "")

        # Check the user's input and take appropriate action
        if [[ "$service" == "ALL" || "$service" == "all" ]]; then
            zenity --info --title "Hercules" --text "Scanning all ports. This may take up to 1 hour to complete." --timeout=5
            sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
        
        #stops the program
        elif [[ "$service" == "stop" ]]; then
            zenity --info --title "Hercules" --text "Stopping program."
            exit 1
        
        #scans a port that you choose
        else
            zenity --info --title "Hercules" --text "Scanning port ${service}." --timeout=5
            sudo nmap -sS 192.168.1.1/24 -p $service --open
        fi
    }
fi

Hercules