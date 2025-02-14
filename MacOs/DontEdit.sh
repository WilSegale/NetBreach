#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
yellow="\033[33m"
BRIGHT='\033[1m'
NC='\033[0m' # No Color

# grabes the username by using the "whoami" command and then grabs the hostname by using "hostname" command
username=$(whoami)
hostname=$(hostname)
os_name=$(uname)

# var that holds the ssh connection list
ssh_connection="connect.log"

#name of program
NameOfProgram="NetBreachX"

# OS of the computer
OS="darwin"

# For the wget functionality to work
SITE_URL="https://google.com"

# Root user
root=0

#easy way to change the logo faster
logo=NetBreachX

# the array that holds nothing in it
empty=("")

# The array that contains the alphabet
alphabet=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

# The yes array that contains the yes input
yes=("YES" "Y" "yes" "y")
no=("NO" "N" "no" "n")

#the Manual array so the user can see the manual function
Manual=("Manual" "manual" "MANUAL" "Man" "MAN")

# The array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# The array to have auto connect work
auto=("--auto" "--Auto" "==AUTO" "--autoconnect" "--Autoconnect" "--AUTOCONNECT")

# the array to have help message work
HELP=("help" "HELP" "Help" "-h" "--help" "--HELP" "--Help")

#hold the array for the skip function
skip=("--skip" "--SKIP" "--Skip" "-s" "-S")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

#auto finds the ip address of the router
IP_ADDRESS=$(route -n get default | awk '/gateway/ {print $2}')

# List of required packages/commands (separated by spaces)
required_packages=("wget" "hydra" "nmap" "ssh" "mysql" "figlet" "zenity")

# Packages to check for installation
Packages=(
    "ssh"
    "mysql"
    "mysql-server"
    "python3-pip"
    "wget"
    "hydra"
    "nmap"
    "figlet"
    "zenity"
    "freerdp"
)

# PIP packages that will be uninstalled if they are installed
pipPackages=(
    "asyncio"
    "pyfiglet"
)