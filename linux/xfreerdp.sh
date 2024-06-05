#!/bin/bash
source DontEdit.sh
clear

# Function to handle xfreerdp connection
ConnectXfreerdp() {
    if [[ "${OSTYPE}" == "linux-gnu"* ]]; then


        FILE="connections.env"
        figlet -f slant "xfreerdp"

        # Check if file exists
        if [ -e "${FILE}" ]; then
            source "${FILE}"
            xfreerdp /u:"${XFREERDP_USERNAME}" /v:"${XFREERDP_IP}" /p:"${XFREERDP_PASSWORD}"
        else
            sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
            echo
            read -p "Input IP: " ip
            read -p "Input username: " username
            read -s -p "Input password: " password
            echo
            read -p "Do you want to save this connection? (y/n) " save
            if [[ "${save}" == "y" ]]; then
                echo "XFREERDP_IP=${ip}" >> "${FILE}"
                echo "XFREERDP_USERNAME=${username}" >> "${FILE}"
                echo "XFREERDP_PASSWORD=${password}" >> "${FILE}"
                
                echo "Loading xfreerdp server..."
                sleep 1
                xfreerdp /v:"${ip}" /u:"${username}" /p:"${password}"
            else
                echo
                echo "Loading xfreerdp server..."
                sleep 1
                xfreerdp /u:"${username}" /v:"${ip}" /p:"${password}"
                exit
            fi
        fi
    else
        echo -e "[ ${RED}FAIL${NC} ]This script can only be run on Linux"
        exit

    fi
}

# Call the function
ConnectXfreerdp
