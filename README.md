# NetBreach

<img src="NetBreach.JPG" alt="alt text" width="200" height="200">

# !Do not use this software in Schools or Business! 

## First type 
```git
git clone https://github.com/WilSegale/NetBreach.git
```

## There is also a README file in your os folder it holds more info about the program
# second step is to type
```bash
sudo python3 setup.py
```

## If you want more info about the program in your OS folder, type

```bash 
open README.md
```
## this file will explain how the program works and how to use it to it's full capacity 
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

sudo nano known_hosts
```

# You can type the following command in the CLI
```plaintext
ssh [username]@[hostname]
```

# if the user you are attacking has changed their port number for ssh type this command instead of the one on top

```plaintext
ssh [username]@[hostname] -p [port Number]
```