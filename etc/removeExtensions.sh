#!/bin/bash

# Define color codes for printing colored output
GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'

# Array of possible "yes" values
yes=("yes" "Yes" "YES" "y" "Y")

#array of possible of lists that will show what inside the extension file
list=("list" "show me what inside")

# Path to the extensions directory
extensions_dir="${HOME}/.vscode/extensions"

# Check if the script can access the extensions directory
if ! cd "$extensions_dir"; then
    echo -e "${RED}[-]${RESET} ERROR"
    echo -e "${RED}[-]${RESET} Failed to access the extensions directory."
    exit 1
fi

# Function to remove all extensions
remove_all_extensions() {
    # Check if the extensions directory is empty
    if [[ -z "$(find "${extensions_dir}" -mindepth 1 -print -quit)" ]]; then
        echo "Folder is empty"
    else
        # Loop through each file in the directory
        for file in *; do
            if [ -d "$file" ]; then
                # Delete the extension directory
                echo "Deleting extension: $file"
                rm -rf "$file"
            fi
        done

        # Check the exit status of the previous command
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[+]${RESET} DONE"
            echo -e "${GREEN}[+]${RESET} All extensions from vscode have been removed. You will have to restart vscode."
        else
            echo -e "${RED}[-]${RESET} ERROR"
            echo -e "${RED}[-]${RESET} Failed to remove extensions."
        fi
    fi
}

# Prompt the user to confirm the removal of all extensions
list_extensions() {
    echo "Are you sure you want to remove all extensions?"
    read -p "YES, NO OR LIST: " YesOrNoOrList
    if [[ " ${yes[*]} " == *" $YesOrNoOrList "* ]]; then
        remove_all_extensions
    elif [[ " ${list[*]}" == *" $YesOrNoOrList "* ]]; then
        ls $extensions_dir
        sleep 1
        echo
        list_extensions
    else
        echo -e "${RED}[-]${RESET} Ok, your extensions will not be removed."
        exit 1
    fi
}
list_extensions