#!/bin/bash

# Function to display a simple dialog box
show_dialog() {
    dialog --backtitle "Bash GUI Example" --title "Simple Dialog" --msgbox "$1" 10 30
}

# Main script
input=$(dialog --backtitle "Bash GUI Example" --title "Input Dialog" --inputbox "Enter your name:" 10 30 3>&1 1>&2 2>&3 3>&-)

if [ -n "$input" ]; then
    show_dialog "Hello, $input!"
else
    show_dialog "You canceled the input."
fi

