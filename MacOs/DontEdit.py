# Import necessary modules
import datetime
import platform
import time
import os
import urllib.request
import logging
import sys
import requests
import random
import subprocess


# easy way to read the root user function
ROOT = 0


# list of the files to remove

RemoveFile = ("ERROR.log","ERROR.LOG")


# easy way for the computer to read subprocess.run
lineArt = subprocess.run

#name of the os
OS = "Darwin"

# Define color codes for console output
BRIGHT = '\033[1m'
GREEN = "\033[92m"
RED = "\033[91m"
BLUE = "\033[34m"
YELLOW = "\033[33m"
ORANGE_Start = "\033[38;2;255;165;0m"
GRAY_TEXT = "\033[90m"
CYAN_TEXT = "\033[36m"
RESET = "\033[0m"

# Define constants for command-line arguments
HELP = ["--HELP", "--Help", "--help", "-h", "-H"]
GUI = ["--GUI", "--Gui", "--gui"]
GLOBAL = ["--GLOBAL", "--Global", "--global"]
LOCAL = ["--LOCAL", "--Local", "--local"]
GuiLocal = ["--GUI-LOCAL", "--Gui-local", "--gui-local"]
installRequirement = ["--INSTALL", "--install"]
uninstallRequirement = ["--UNINSTALL", "--uninstall"]
FIX = ["--FIX", "--fix"]

# bash commands list
LocalScript = ["bash", "localScript.sh"]  # runs the script in local mode
GlobalScript = ["bash", "GlobalScript.sh"]  # runs the script in global mode
GuiScript = ["bash", "GuiScript.sh"] # runs the scirpt in GUI mode
GuiLocalScript = ["bash", "GuiLocal.sh"]  # runs the script in GUI-Local mode