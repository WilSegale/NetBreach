# !Do not use this software in Schools or Business!

## Bugs and Issues
### If you find any bugs or issues click on [Email me](mailto:wsegalework@gmail.com) to contact me about the issues.

## Type first
```bash
bash requirements.sh or 
python3 Hercules.py --install
```

## if you want to remove the requirements you can type
```bash
bash uninstall.sh or
python3 Hercules.py --uninstall
```

## To use the program you can type the following commands
```bash 
python3 Hercules.py --local,
sudo python3 Hercules.py --global,
sudo python3 Hercules.py --gui,
sudo python3 Hercules.py --Gui-Local
```

## If you are wondering how to use this script just type

```bash
python3 Hercules.py --help or python3 Hercules.py -h
```

## The requirements file will automatically install the requirements that are needed for the program to run successfully

### This software is going to help you crack passwords.
### To crack VNC(5900) do not type anything in the "Username" input. Just type the ip address in the hostname input field.


# Troubleshooting SSH: Remote Host Identification Changed

If you encounter the following error message when connecting to an SSH server:

```plaintext
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```
# Or you can go to this file and delate all the hashes that are connected to previously used ssh hosts
```ssh hash config```
```plaintext
cd ~/.ssh

open known_hosts
```

# You can type the following command in the CLI
```plaintext
ssh [username]@[hostname]
```

# If the user you are attacking has changed their port number for ssh type this command instead of the one on top

```plaintext
ssh [username]@[hostname] -p [port Number]
```

# Trouble shooting the error log error message
## if you ever get this message

```plaintext
ERROR = open("ERROR.log", "a")
    PermissionError: [Errno 13] Permission denied: 'ERROR.log'
```
## You get rid of this message by going to the ERROR.log file and remove it. By doing 
```bash 
sudo rm -rf ERROR.log
``` 

## This will fix the program for you.


## If you are having trouble installing the packages you can install them this way
```plain text
    sudo apt install zabbix-server-mysql -y
    sudo apt install pip -y
    sudo apt install mysql-server -y
    sudo apt install curl -y
    sudo apt install wget -y
    sudo apt install hydra -y
    sudo apt install nmap -y
    sudo apt install mysql -y
    sudo apt install figlet -y
    sudo apt install zenity -y
    sudo apt install tigervnc-viewer -y
```