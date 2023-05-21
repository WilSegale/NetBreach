import colorama
from tqdm import tqdm
import platform
import datetime
import time
import os
import urllib.request
import logging

# Initialize Colorama
colorama.init()

# Get the current time
current_time = datetime.datetime.now().time()

# Format the time with AM/PM
formatted_time = current_time.strftime("%H:%M:%S %p")

root = 0


def connect(host="https://google.com/"):
    try:
         urllib.request.urlopen(host)
         return True
    except:
         return False


if connect():
    if platform.system() == "Darwin":
        if os.geteuid() == root:
            for i in tqdm(range(0, 100), ascii=False, colour="green", desc="Loading Hercules"):
                time.sleep(0.1)
                pass
            os.system("bash .script.sh")
        else:
            logging.error(f"{formatted_time} Please run as root.")
            print(f"{colorama.Fore.RED}{formatted_time} Please run as root.")
    else:
        logging.warning(f"{formatted_time} Wrong OS. Please use the correct OS.")
        print(f"{colorama.Fore.RED}{formatted_time} Wrong OS. Please use the correct OS.")
else:
    logging.error(f"{formatted_time} You are offline. Please connect to the internet.")
    print(f"{colorama.Fore.RED}{formatted_time} You are offline. Please connect to the internet.")
