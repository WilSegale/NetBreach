#!/bin/bash

# Define your Wi-Fi network SSID
read -p "SSID : " SSID
# Function to connect to Wi-Fi
connect_to_wifi() {
    # Check if the Wi-Fi interface is available
    if [ -z "$(networksetup -listallhardwareports | grep -A1 Wi-Fi | grep Device | awk '{print $2}')" ]; then
        echo "Wi-Fi interface not found. Make sure Wi-Fi is enabled on your Mac."
        exit 1
    fi

    # Check if the password file exists
    if [ ! -f wifi_password.txt ]; then
        echo "Password file 'wifi_password.txt' not found. Please create the file and enter your Wi-Fi password."
        exit 1
    fi

    # Read the Wi-Fi password from the file
    PASSWORD=$(cat wifi_password.txt)

    # Try to connect to Wi-Fi
    networksetup -setairportnetwork en0 "${SSID}" "${PASSWORD}"

    # Check if the connection was successful
    if [ $? -eq 0 ]; then
        echo "Connected to Wi-Fi: ${SSID}"
    else
        echo "Failed to connect to Wi-Fi: ${SSID}"
        exit 1
    fi
}

# Main script
echo "Connecting to Wi-Fi..."

connect_to_wifi

echo "Wi-Fi connection established."
