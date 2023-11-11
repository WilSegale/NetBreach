
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# OS of the computer
OS="darwin"

# For the wget functionality to work
SITE_URL="https://google.com"

# Root user
root=0

# the array that holds nothing in it
empty=("")

alphabet=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

# The yes array that contains the yes input
yes=("yes" "YES" "y" "Y")
no=("no" "NO" "n" "N")
# The array that contains the exit input
exit=("exit" "quit" "EXIT" "QUIT" "STOP" "stop")

# Gets the current time in a 12-hour format
CURRENT_TIME=$(date +"%I:%M:%S %p")

# Gets current date in mm/dd/yyyy format
CURRENT_DATE=$(date +"%m/%d/%Y")

# List of required packages/commands (separated by spaces)
required_packages=("wget" "nmap" "hydra" "ssh" "mysql")
