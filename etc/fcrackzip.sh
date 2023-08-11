#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    function FCRACKZIP() {
        packages=("fcrackzip" "figlet" "ffmpeg")
        pass="945531"
        read -s -p "Enter Password: " EnterPassword
        echo

        if [ "$EnterPassword" != "$pass" ]; then
            echo "Wrong Password"
            say "Wrong password"
            ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" -frames:v 1 image.jpg
            open image.jpg
            exit 1
        else
            missing_packages=()
            for package in "${packages[@]}"; do
                if ! command -v "$package" >/dev/null 2>&1; then
                    missing_packages+=("$package")
                fi
            done

            if [ ${#missing_packages[@]} -eq 0 ]; then
                clear
                echo "Packages are already installed."
            else
                echo "Installing missing packages: ${missing_packages[*]}"
                if command -v brew >/dev/null 2>&1; then
                    brew install "${missing_packages[@]}"
                else
                    echo "Error: Homebrew is required for package installation."
                    exit 1
                fi
                clear
                echo "Packages installed."
            fi

            figlet -f slant "fcrackzip"
        fi
    }

    function run() {
        ls -a
        read -p "Input the file name: " FileName
        read -p "Input the password file name: " PasswordFile
        if [[ $FileName == *.zip ]]; then
            if [[ -z $FileName || -z $PasswordFile ]]; then
                echo "Please input the file name and password file name."
                clear
                figlet -f slant "fcrackzip"
                ls -a
                run
            else
                fcrackzip -u -D -p "${PasswordFile}" "${FileName}"
                unzip "${FileName}"
            fi
        else
            echo "File does not end with .zip"
            sleep 1
            run
        fi
    }
    else
        function FCRACKZIP() {
            packages=("fcrackzip" "figlet")
            pass="945531"
            read -s -p "Enter Password: " EnterPassword
            echo

            if [ "$EnterPassword" != "$pass" ]; then
                echo "Wrong Password"
                paplay /usr/share/sounds/freedesktop/stereo/bell.oga
                ffmpeg -f x11grab -framerate 30 -video_size 1280x720 -i "$DISPLAY" -vframes 1 image.jpg
                xdg-open image.jpg
                exit 1
            else
                missing_packages=()
                for package in "${packages[@]}"; do
                    if ! command -v "$package" >/dev/null 2>&1; then
                        missing_packages+=("$package")
                    fi
                done

                if [ ${#missing_packages[@]} -eq 0 ]; then
                    clear
                    echo "Packages are already installed."
                else
                    echo "Installing missing packages: ${missing_packages[*]}"
                    if command -v apt-get >/dev/null 2>&1; then
                        sudo apt-get install "${missing_packages[@]}"
                    else
                        echo "Error: APT package manager is required for package installation."
                        exit 1
                    fi
                    clear
                    echo "Packages installed."
                fi

                figlet -f slant "fcrackzip"
            fi
        }

        function run() {
            ls -a
            read -p "Input the file name: " FileName
            read -p "Input the password file name: " PasswordFile
            if [[ $FileName == *.zip ]]; then
                if [[ -z $FileName || -z $PasswordFile ]]; then
                    echo "Please input the file name and password file name."
                    clear
                    figlet -f slant "fcrackzip"
                    ls -a
                    run
                else
                    fcrackzip -u -D -p "${PasswordFile}" "${FileName}"
                    unzip "${FileName}"
                fi
            else
                echo "File does not end with .zip"
                sleep 1
                run
            fi
        }
fi

FCRACKZIP
run
