import subprocess
import datetime
import logging
import os

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
        print("DONE running linux command")
        logger.info(f"Running command: {' '.join(linux_command)}")
        try:
            subprocess.run(linux_command, check=True)
        except subprocess.CalledProcessError:
            logger.error("Error running command")
    elif platform == "macos":
        print("DONE running macos command")
        logger.info(f"Running command: {' '.join(macos_command)}")
        try:
            subprocess.run(macos_command, check=True) 
        except subprocess.CalledProcessError:
            logger.error("Error running command")
