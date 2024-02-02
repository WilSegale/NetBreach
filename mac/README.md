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

## To use the program type use can use the following commands
```bash 
sudo python3 Hercules.py --local,
sudo python3 Hercules.py --global,
sudo python3 Hercules.py --gui,
sudo python3 Hercules.py --Gui-Local
```

## If you are wondering how to use this script just type

```bash
python3 Hercules.py --help or python3 Hercules.py -h
```

## If you are wondering what the requirements do type

```bash
bash requirements.sh --help or bash requirements.sh -h
```

### This software is going to help you crack passwords.
### To crack VNC(5900) do not type anything in the "Username" input. Just type the ip address in the hostname input field.


# Troubleshooting SSH: Remote Host Identification Changed

If you encounter the following error message when connecting to an SSH server:

```plaintext
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

# You can type the following command in the CLI
```plaintext
ssh [username]@[hostname]"
```

# Or you can go to this file and delate all the hashes that are connected to previously used ssh hosts
```ssh hash config```
```plaintext
cd ~/.ssh

sudo nano known_hosts
```

# if the user you are attacking has changed their port number for ssh type this command instead of the one on top

```plaintext
ssh [username]@[hostname] -p [port Number]
```