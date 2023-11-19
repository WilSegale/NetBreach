# Import necessary modules
import datetime
import platform
import time
import os
import urllib.request
import logging
import sys
import subprocess

# Define color codes for console output
RED = '\033[0;31m'
GREEN = '\033[0;32m'
BRIGHT = '\033[1m'
GREEN = "\033[92m"
RED = "\033[91m"
RESET = "\033[0m"

# Define constants for command-line arguments
HELP = ["--help", "-h"]
GUI = ["--GUI", "--gui"]
GLOBAL = ["--global", "--GLOBAL"]
LOCAL = ["--local", "--LOCAL"]
