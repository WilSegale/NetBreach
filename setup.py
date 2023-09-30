import os
import datetime
import logging
from colorama import Fore, Style  # Import specific classes/functions from colorama

current_time = datetime.datetime.now().time()
formatted_time = current_time.strftime("%H:%M:%S %p")

# Configure logging
logging.basicConfig(filename='ERROR.log', level=logging.INFO)
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)
logging.getLogger().addHandler(console_handler)

GREEN = Fore.GREEN
RED = Fore.RED
RESET = Style.RESET_ALL
BRIGHT = Style.BRIGHT

def CheckOS():
    # Check for Linux or macOS (Darwin)
    if os.uname().sysname == "Linux":
        os.system("sudo rm -rf mac")
        os.system("sudo rm -rf setup.py")
        print("[+] DONE!")
    elif os.uname().sysname == "Darwin":
        os.system("sudo rm -rf linux")
        os.system("sudo rm -rf setup.py")
        print("[+] DONE!")
    else:
        logging.error(f'{formatted_time} Your system is not supported.')
        print(f'{BRIGHT}{RED}[-] Your system is not supported{RESET}')
CheckOS()