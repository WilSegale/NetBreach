import subprocess
import datetime
import logging
import os
import time
import sys

# color vars for the user to understand what went wrong
GREEN = "\033[92m"
RED = "\033[91m"
RESET = "\033[0m"

# Set up logging 
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# Create log directory if it doesn't exist
log_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logs")
os.makedirs(log_dir, exist_ok=True)

# Define log file path
log_file_path = os.path.join(log_dir, f"{os.path.splitext(os.path.basename(__file__))[0]}_{datetime.datetime.now():%Y%m%d_%H%M%S}.log")
handler = logging.FileHandler(log_file_path)
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)

# Platform specific commands 
linux_command = ["rm", "-rf", "MacOs", "WINDOWS", "setup.py"]  
macos_command = ["rm", "-rf", "Linux", "WINDOWS", "setup.py"]
Windows_command = ["del", "MacOS", "Linux", "setup.py"] 
try:
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
except KeyboardInterrupt:
    print("\nSetup.py interrupted")
    logger.error("Setup.py interrupted")
    sys.exit(1)
    
if __name__ == "__main__":
    try: 
        # Detect platform
        if os.name == "posix":
            if os.uname().sysname == "Linux":
                platform = "linux"
            elif os.uname().sysname == "Darwin":
                platform = "macos"
            elif os.uname().sysname == "Windows":
                platform = "windows"
            else:
                platform = None
                logger.error("Unsupported platform")
            
            if platform:
                # Run command
                print_loading_bar(50)
                print(f"\n[ {GREEN}DONE{RESET} ] running command")
                if platform == "linux":
                    command = linux_command
                
                elif platform == "macos":
                    command = macos_command

                elif platform == "windows":
                    command = Windows_command
                    
                logger.info(f"Running command: {' '.join(command)}")
                try:
                    subprocess.run(command, check=True, capture_output=True, text=True)
                except subprocess.CalledProcessError as e:
                    logger.error(f"Error running command: {e}")
            else:
                print(f"{RED}Unsupported platform{RESET}")
                logger.error("Unsupported platform")
    except KeyboardInterrupt:
        print("\nSetup.py interrupted")
        logger.error("Setup.py interrupted")
        sys.exit(1)