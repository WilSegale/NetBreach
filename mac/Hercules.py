from tqdm import tqdm
import datetime
import platform
import time
import os
import urllib.request
import logging

# gets the current time and formats it HH:MM:SS
current_time = datetime.datetime.now().time()
formatted_time = current_time.strftime("%I:%M:%S %p")

# Get the current date
current_date = datetime.datetime.now().strftime("%m/%d/%Y")

# easy way to read the root user function
root = 0

# makes the log file accessible to read for the user and developer
logging.basicConfig(filename="ERROR.log", level=logging.ERROR)


def connect(host="google.com"):
    try:
        urllib.request.urlopen("http://" + host)  # Try to open a connection to the host
        return True  # If successful, return True
    except:
        return False  # If unsuccessful, return False


if connect() == True:  # Makes sure that the user is connected to the internet
    if platform.system() == "Darwin":  # Check if the current OS is macOS
        if os.geteuid() == root:  # Check if running as root
            with tqdm(total=100, ascii=False, bar_format='{l_bar}{bar}| {n_fmt}/{total_fmt}', ncols=80,
                      colour="green", desc="Loading Hercules", dynamic_ncols=True) as pbar:
                for _ in range(100):
                    time.sleep(0.1)  # Simulate loading delay
                    pbar.update(1)
            os.system("bash script.sh")  # Replace with your actual script to run after loading
        else:
            logging.critical(f"TIME:{formatted_time} Please run as root. DATE:{current_date}")
            print(f"TIME:{formatted_time} Please run as root. DATE:{current_date}")
    else:
        logging.warning(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
else:
    logging.critical(f"TIME:{formatted_time} You are offline. Please connect to the internet. DATE:{current_date}")
    print(f"TIME:{formatted_time} You are offline. Please connect to the internet. Date:{current_date}")
