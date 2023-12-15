from DontEdit import *

# Assuming OS is defined somewhere in your code
OS = "your_os_here"  

def on_internet():
    print("You are connected to the internet.")
    # Your code for when the user is on the internet

def offline():
    print("You are not connected to the internet.")
    # Your code for when the user is offline

def show_AUTO():
    current_time = datetime.datetime.now().time()
    formatted_time = current_time.strftime("%I:%M:%S %p")
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")
    ROOT = 0

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url, timeout=1)
            return True
        except:
            return False

    # Makes sure that the user is connected to the internet
    try:
        if platform.system() == OS:
            # checks if the user is running as root
            if os.geteuid() != ROOT:
                raise PermissionError("You are not running as root")

            if connect() == False:
                on_internet()
            else:
                offline()
        else:
            raise OSError(f"Wrong OS. Please use the correct OS. DATE:{current_date}")

    except (PermissionError, OSError) as e:
        print(f"TIME:{formatted_time} {e}")
on_internet()

# Rest of your code remains unchanged
# ...
