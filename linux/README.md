# !Do not use this software in Schools or Business!

<img src="Linux Logo.JPG" alt="Linux Verison of the program" width="200" height="200">

# Home Page
- [Home README.md](../)

## Bugs and Issues
### If you find any bugs or issues click on [Email me](mailto:wsegalework@gmail.com) to contact me about the issues.

## Type first
```bash
bash requirements.sh or 
python3 NetBreachX.py --install
```

## if you want to remove the requirements you can type
```bash
bash uninstall.sh or
python3 NetBreachX.py --uninstall
```

## To use the program you can type one of the following commands
```bash
sudo python3 NetBreachX.py --GUI
sudo python3 NetBreachX.py --Global
sudo python3 NetBreachX.py --MANUAL-GLOBAL
sudo python3 NetBreachX.py --GlobalHelp
sudo python3 NetBreachX.py --skip-manual-global
sudo python3 NetBreachX.py --SKIPGLOBAL
sudo python3 NetBreachX.py --uninstall
sudo python3 NetBreachX.py --fix
```

## Dont need to use root to run
```bash
python3 NetBreachX.py --local
python3 NetBreachX.py --GUI-LOCAL
python3 NetBreachX.py --MANUAL-LOCAL
python3 NetBreachX.py --xfreerdp
python3 NetBreachX.py --pipForce
python3 NetBreachX.py --auto
python3 NetBreachX.py --skip-Local
python3 NetBreachX.py --skip-manual-local
python3 NetBreachX.py --Local-Help
python3 NetBreachX.py --Global-Help
python3 NetBreachX.py --upgrade
python3 NetBreachX.py --install
python3 NetBreachX.py --version
```

## If you want to see packages that are installed or not type
```bash 
python3 NetBreachX.py --list
``` 

## If you want to see the current version of the packages that are installed you can do so by doing 

```bash
python3 NetBreachX.py --version
```

## If you are wondering how to use this script just type

```bash
python3 NetBreachX.py --help or python3 NetBreachX.py -h
```

## The requirements file will automatically install the requirements that are needed for the program to run successfully

### This software is going to help you crack passwords.
### To crack VNC(5900) do not type anything in the "Username" input. Just type the ip address in the hostname input field.


# Troubleshooting SSH: Remote Host Identification Changed

# If you encounter the following error message when connecting to an SSH server:

```plaintext
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```
# You can go to this file and delete all the hashes that are connected to previously used ssh hosts
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
sudo rm -rf ERROR.log,
python3 NetBreachX.py --fix
``` 
## This will fix the program for you.