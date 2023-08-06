
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

            ls -a --color

    function run(){
        read -p "Input the file name: " FileName
        read -p "Input the password file name: " PasswordFile
        if [[ $FileName == *.zip ]]; then
            if [[ $FileName == "" || $PasswordFile == ""  
                || $FileName == "" && $PasswordFile == "" ]]; then
                echo "Please input the file name and password file name."
                clear
                figlet -f slant "fcrackzip"
                
                ls -a --color
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
}

    FCRACKZIP
    run

elif [[ "${OSTYPE}" == "Linux" ]]; then
    function FCRACKZIP() {
        packages=("fcrackzip" "figlet" "ffmpeg")  # "ffmpeg" is optional if not required.
        pass="945531"
        read -s -p "Enter Password: " EnterPassword
        echo

        if [ "$EnterPassword" != "$pass" ]; then
            echo "Wrong Password"
            # Use any Linux text-to-speech command or remove this line if not needed.
            # For example, "spd-say" is a common text-to-speech command in Linux.
            spd-say "Wrong password"
            # Use an alternative to "ffmpeg" for capturing video on Linux, like "v4l2-ctl" or "ffmpeg -f v4l2".
            # Replace "avfoundation" with the appropriate video capture device on Linux (e.g., /dev/video0).
            ffmpeg -f v4l2 -framerate 30 -video_size 1280x720 -i "/dev/video0" -frames:v 1 image.jpg
            xdg-open image.jpg  # Use "xdg-open" to open the image using the default application on Linux.
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
                # Use the appropriate package manager based on the Linux distribution.
                if command -v apt-get >/dev/null 2>&1; then
                    sudo apt-get update
                    sudo apt-get install "${missing_packages[@]}"
                elif command -v dnf >/dev/null 2>&1; then
                    sudo dnf install "${missing_packages[@]}"
                elif command -v yum >/dev/null 2>&1; then
                    sudo yum install "${missing_packages[@]}"
                else
                    echo "Error: Package manager not found (apt, dnf, or yum required)."
                    exit 1
                fi
                clear
                echo "Packages installed."
            fi

            figlet -f slant "fcrackzip"

            ls -a --color
        fi
    }

    function run() {
        read -p "Input the file name: " FileName
        read -p "Input the password file name: " PasswordFile
        if [[ $FileName == *.zip ]]; then
            if [[ $FileName == "" || $PasswordFile == "" || ($FileName == "" && $PasswordFile == "") ]]; then
                echo "Please input the file name and password file name."
                clear
                figlet -f slant "fcrackzip"
                ls -a --color
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

    FCRACKZIP
    run
fi