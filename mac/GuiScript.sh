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
    
fi

