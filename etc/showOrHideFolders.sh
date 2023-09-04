#!/bin/bash

# Define arrays containing valid options for showing and hiding folders.
show=("Show" "show" "SHOW")
hide=("Hide" "hide" "HIDE")

# Define a function to show or hide folders based on user input.
show_hide() {
    local input="$1"  # Store the user input in a local variable.
    local found=false  # Create a flag to track if a valid option is found.

    # Check if the input matches any option in the "show" array.
    for option in "${show[@]}"; do
        if [[ "$option" == "$input" ]]; then
            # If a match is found, set Finder to show hidden files and restart it.
            defaults write com.apple.finder AppleShowAllFiles -bool true
            killall Finder
            found=true
            echo "[+] Showing Files..."

            break
        fi
    done

    # If no match is found in the "show" array, check the "hide" array.
    if [[ "$found" == false ]]; then
        for option in "${hide[@]}"; do
            if [[ "$option" == "$input" ]]; then
                # If a match is found, set Finder to hide hidden files and restart it.
                defaults write com.apple.finder AppleShowAllFiles -bool false
                killall Finder
                found=true
                echo "[+] Hidding Files..."
                break
            fi
        done
    fi

    # If the input is neither in the "show" nor "hide" array, display "Unknown option".
    if [[ "$found" == false ]]; then
        echo "Unknown option"
        sleep 1
        read -p "Do you want to show or hide folders: " new_input
        show_hide "$new_input"  # Call the function recursively with the new input.
    fi
}

# Ask the user for input.
read -p "Do you want to show or hide folders: " ShowOrHide

# Call the show_hide function with the user input.
show_hide "$ShowOrHide"
