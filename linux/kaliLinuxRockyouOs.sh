#!/bin/bash

# Function to detect the Linux distribution
detect_linux_distribution() {
    if [[ -f /etc/os-release ]]; then
        # Read the /etc/os-release file
        os_info=$(cat /etc/os-release | tr '[:upper:]' '[:lower:]')
        
        # Check for "kali"
        if echo "${os_info}" | grep -q "kali"; then
            echo "This system is running Kali Linux."
            echo "would you like me to grab the built in rockyou.txt file for you? (y/n)"
            read -p ">>> " GrabRockyou
            if [[ $GrabRockyou == "y" ]]; then
                echo "grabbing rockyou.txt"
                cd "$HOME/usr/share/wordlist/rockyou" x
                #gzip -d rockyou.txt.gz
                echo $x
                #echo "done"
            else
                echo "ok"
            fi
        elif echo "${os_info}" | grep -q "debian"; then
            echo "This system is running Debian-based Linux (but not Kali)."
        else
            echo "This system is running a Linux distribution other than Kali."
        fi
    elif [[ -f /etc/issue ]]; then
        # Fall back to checking /etc/issue
        os_info=$(cat /etc/issue | tr '[:upper:]' '[:lower:]')
        
        if echo "${os_info}" | grep -q "kali"; then
            echo "This system is running Kali Linux."
        elif echo "${os_info}" | grep -q "debian"; then
            echo "This system is running Debian-based Linux (but not Kali)."
        else
            echo "This system is running a Linux distribution other than Kali."
        fi
    else
        echo "Unable to detect the Linux distribution. System files missing."
    fi
}

# Call the function
detect_linux_distribution