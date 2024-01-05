import pathlib
import subprocess
import datetime
import logging

# Set up logging 
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
handler = logging.FileHandler(f"{pathlib.Path(__file__).stem}_{datetime.datetime.now():%Y%m%d_%H%M%S}.log")
handler.setLevel(logging.DEBUG)
logger.addHandler(handler)

# Platform specific commands 
linux_command = ["rm", "-rf", "mac", "setup.py"]  
macos_command = ["rm", "-rf", "linux", "setup.py"]

if __name__ == "__main__":

  # Detect platform
  if pathlib.os.name == "posix":
    if pathlib.os.uname().sysname == "Linux":
      platform = "linux"
    elif pathlib.os.uname().sysname == "Darwin":
      platform = "macos"

  # Run command
  if platform == "linux":
    print("DONE runing linux command")
    logger.info(f"Running command: {' '.join(linux_command)}")
    try:
      subprocess.run(linux_command, check=True)
    except subprocess.CalledProcessError:
      logger.error("Error running command")
  elif platform == "macos":
    print("DONE runing macos command")
    logger.info(f"Running command: {' '.join(macos_command)}")
    try:
      subprocess.run(macos_command, check=True) 
    except subprocess.CalledProcessError:
      logger.error("Error running command")
  else:
    logger.error("Unsupported platform")