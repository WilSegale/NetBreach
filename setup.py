from DontEdit import *
ERROR = open("ERROR.log", "a")

# Terminal commands
MacOS_Command = "sudo rm -rf linux && sudo rm -rf setup.py"
LinuxCommand = "sudo rm -rf mac && sudo rm -rf setup.py"

RED = '\033[0;31m'
GREEN = '\033[0;32m'
BRIGHT = '\033[1m'
RESET = '\033[0m'

current_time = datetime.datetime.now().time()
formatted_time = current_time.strftime("%H:%M:%S %p")

def CheckOS():
    # Check for Linux or macOS (Darwin)
    if os.uname().sysname == "Linux":
        subprocess.run(LinuxCommand, shell=True, check=True)
        print("[+] DONE!")
    elif os.uname().sysname == "Darwin":
        subprocess.run(MacOS_Command, shell=True, check=True)
        print("[+] DONE!")
    else:
        print(f"{formatted_time} Your system is not supported.", file=ERROR)
        print(f'{BRIGHT}{RED}[-] Your system is not supported{RESET}')

# Close the ERROR.log file when done
with open("ERROR.log", "a") as ERROR:
    CheckOS()
