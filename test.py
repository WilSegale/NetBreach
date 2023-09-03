import subprocess
message = "Hello World!"
title = "Dialog Title"

# Construct the AppleScript command
applescript_command = f'display dialog "{message}" with title "{title}"'

# Execute the AppleScript command using subprocess
try:
    subprocess.run(['osascript', '-e', applescript_command], check=False)
except subprocess.CalledProcessError as error:
    print(f"An error occurred: {error}")

