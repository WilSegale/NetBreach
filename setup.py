import subprocess
import datetime
import logging
import os
import time

GREEN = "\033[92m"
RESET = "\033[0m"

# Set up logging 
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
current_file_path = os.path.abspath(__file__)
log_file_path = os.path.join(os.path.dirname(current_file_path), f"{os.path.splitext(os.path.basename(__file__))[0]}_{datetime.datetime.now():%Y%m%d_%H%M%S}.log")
handler = logging.FileHandler(log_file_path)
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)

# Platform specific commands 
linux_command = ["rm", "-rf", "mac", "setup.py"]  
macos_command = ["rm", "-rf", "linux", "setup.py"]

if __name__ == "__main__":

    # Detect platform
    if os.name == "posix":
        if os.uname().sysname == "Linux":
            platform = "linux"
        elif os.uname().sysname == "Darwin":
            platform = "macos"
        else:
            logger.error("Unsupported platform")
            exit(1)

    # Run command
    if platform == "linux":
        def print_loading_bar(iterations, delay=0.1, width=40):
            """
            Prints a loading bar with green dots to visualize progress.
            
            Args:
                iterations (int): Total number of iterations.
                delay (float, optional): Delay between updates in seconds. Default is 0.1 seconds.
                width (int, optional): Width of the loading bar. Default is 40 characters.
            """
            for loadingBar in range(iterations + 1):
                progress = loadingBar / iterations  # Calculate the progress ratio
                bar_length = int(progress * width)  # Calculate the number of dots for the current progress
                bar = GREEN + '•' * bar_length + RESET + ' ' * (width - bar_length)  # Construct the loading bar string
                percentage = int(progress * 100)  # Calculate the percentage of completion
                
                # Print the loading bar and percentage, replacing the line each iteration
                print(f'\rRunning Setup.py [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        print("\nDONE running Linux command")
        logger.info(f"Running command: {' '.join(linux_command)}")
        try:
            subprocess.run(linux_command, check=True)
        except subprocess.CalledProcessError:
            logger.error("Error running command")
    elif platform == "macos":
        def print_loading_bar(iterations, delay=0.1, width=40):
            """
            Prints a loading bar with green dots to visualize progress.
            
            Args:
                iterations (int): Total number of iterations.
                delay (float, optional): Delay between updates in seconds. Default is 0.1 seconds.
                width (int, optional): Width of the loading bar. Default is 40 characters.
            """
            for loadingBar in range(iterations + 1):
                progress = loadingBar / iterations  # Calculate the progress ratio
                bar_length = int(progress * width)  # Calculate the number of dots for the current progress
                bar = GREEN + '•' * bar_length + RESET + ' ' * (width - bar_length)  # Construct the loading bar string
                percentage = int(progress * 100)  # Calculate the percentage of completion
                
                # Print the loading bar and percentage, replacing the line each iteration
                print(f'\rRunning Setup.py [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        print("\nDONE running MacOs command")
        logger.info(f"Running command: {' '.join(macos_command)}")
        try:
            subprocess.run(macos_command, check=True) 
        except subprocess.CalledProcessError:
            logger.error("Error running command")
