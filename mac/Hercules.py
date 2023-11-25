from DontEdit import *
from HelpLogo import *

try:
    ERROR = open("ERROR.log", "a")

    ProgramName = "Hercules"

    OS='Darwin'

    #this is for the user to understand what the program does
    if len(sys.argv) == 2 and sys.argv[1] in HELP:
        HelpFile = open("HELP.txt", "w")

        #This is for the user to know what programs are used in this program
        ProgramsUsed = f"+++++++++++++++Programs used+++++++++++++++"
        ProgramsUsedInfo01 = f"\nThis program will help you crack passwords"
        ProgramsUsedInfo02 = f"\nIt has two programs inside it"
        ProgramsUsedInfo03 = f"\none is Hydra and the other is Nmap"

        #this is for the user to understand what the program does
        HowToUse = f"+++++++++++++++How to use++++++++++++++++++"
        HowToUseInfo01 = f"\nTo use the program you have to tell the computer what port you want to scan."
        HowToUseInfo02 = f"\nIt will then scan the port that you asked for on the network and see if any ports that you asked are open."
        HowToUseInfo03 = f"\nIf there are any ports that are open, it will ask for a username and hostname"
        HowToUseInfo04 = f"\nWhen you give the program the username and hostname, it will try to crack that given parameters you gave it."
        breakLine01 = f" "*len(HowToUseInfo04)
        HowToUseInfo05 = f"\nIf you want to use the program locally, you can type {GREEN}'sudo python3 {ProgramName} {LOCAL}'{RESET}"
        breakLine02 = f" "*len(HowToUseInfo05)
        HowToUseInfo06 = f"\nIf you want to use the program on a global network, you can type {GREEN}'sudo python3 {ProgramName} {GLOBAL}'{RESET}"
        breakLine03 = f" "*len(HowToUseInfo06)
        HowToUseInfo07 = f"\nIf you want to use the program with GUI support you can type {GREEN}'sudo python3 {ProgramName} {GUI}'{RESET}"
        
        
        ProgramsUSED = (ProgramsUsed+
                        ProgramsUsedInfo01+
                        ProgramsUsedInfo02+
                        ProgramsUsedInfo03)

        # holds the information about how the program works in a array so it can grab them more easily
        info = (HowToUse+
                HowToUseInfo01 +
                HowToUseInfo02 + 
                HowToUseInfo03 + 
                HowToUseInfo04 +
                breakLine01 +
                HowToUseInfo05 +
                breakLine02 +
                HowToUseInfo06 +
                breakLine03 +
                HowToUseInfo07)
        
        subprocess.run(["figlet", "? HELP ?"])

        print(text_art, file=HelpFile)
        
        #inputs the program used logo in a help file
        #puts the info about the program inside the help file
        print(ProgramsUSED)
        print()

        #Puts the info logo in the help file
        print(ProgramsUSED, file=HelpFile)

        #puts the info about how to use the program inside the help file
        print(info, file=HelpFile)
        #puts the info about how to use the program on the screen
        
        print(info)
        print()
    
    # Puts the program in the GUI mode
    elif len(sys.argv) == 2 and sys.argv[1] in GUI:
        # gets the current time and formats it HH:MM:SS
        current_time = datetime.datetime.now().time()

        formatted_time = current_time.strftime("%I:%M:%S %p")

        # Get the current date
        current_date = datetime.datetime.now().strftime("%m/%d/%Y")

        # easy way to read the root user function
        ROOT = 0

        def connect(url="https://google.com"):
            try:
                urllib.request.urlopen(url)  # Try to open a connection to the host
                return True  # If successful, return True
            except:
                return False  # If unsuccessful, return False

        # Makes sure that the user is connected to the internet    

        if platform.system() == OS:
            #checks if the user is running as root
            if os.geteuid() == ROOT:
                #makes the loading bar visible
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
                        print(f'\rLoading {ProgramName} [{bar}] {percentage} % ', end='', flush=False)
                        
                        time.sleep(delay)  # Pause to control the update rate
                print_loading_bar(50)
                os.system("bash GuiScript.sh")  # the script to run after loading
            else:    
                # makes a pop up dialog to tell the user that the user is not root
                print(f"TIME:{formatted_time} Please run as ROOT. DATE:{current_date}")
                print(f"ERROR:TIME:{formatted_time} Please run as ROOT. DATE:{current_date}", file=ERROR)
        else:
            # makes a pop up dialog to tell the user that the OS is not correct
            # makes a pop up dialog to tell the user that the OS is not correct
            print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
            print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)
    
    # puts the program in GLOBAL mode
    elif len(sys.argv) == 2 and sys.argv[1] in GLOBAL:
        # gets the current time and formats it HH:MM:SS
        current_time = datetime.datetime.now().time()

        formatted_time = current_time.strftime("%I:%M:%S %p")

        # Get the current date
        current_date = datetime.datetime.now().strftime("%m/%d/%Y")

        # easy way to read the root user function
        ROOT = 0

        def connect(url="https://google.com"):
            try:
                urllib.request.urlopen(url)  # Try to open a connection to the host
                return True  # If successful, return True
            except:
                return False  # If unsuccessful, return False

        # Makes sure that the user is connected to the internet    

        if platform.system() == OS:
            #checks if the user is running as root
            if os.geteuid() == ROOT:
                #makes the loading bar visible
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
                        print(f'\rLoading {ProgramName} [{bar}] {percentage} % ', end='', flush=False)
                        
                        time.sleep(delay)  # Pause to control the update rate
                print_loading_bar(50)
                os.system("bash GlobalScript.sh")  # the script to run after loading
            else:    
                # makes a pop up dialog to tell the user that the user is not root
                print(f"TIME:{formatted_time} Please run as ROOT. DATE:{current_date}")
                print(f"ERROR:TIME:{formatted_time} Please run as ROOT. DATE:{current_date}", file=ERROR)
        else:
            # makes a pop up dialog to tell the user that the OS is not correct
            # makes a pop up dialog to tell the user that the OS is not correct
            print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
            print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)
    
    # puts the script in local mode
    elif len(sys.argv) == 2 and sys.argv[1] in LOCAL:
        # gets the current time and formats it HH:MM:SS
        current_time = datetime.datetime.now().time()

        formatted_time = current_time.strftime("%I:%M:%S %p")

        # Get the current date
        current_date = datetime.datetime.now().strftime("%m/%d/%Y")

        # easy way to read the root user function
        ROOT = 0

        def connect(url="https://google.com"):
            try:
                urllib.request.urlopen(url)  # Try to open a connection to the host
                return True  # If successful, return True
            except:
                return False  # If unsuccessful, return False

        # Makes sure that the user is connected to the internet    

        if platform.system() == OS:
            #checks if the user is running as root
            if os.geteuid() == ROOT:
                #makes the loading bar visible
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
                        print(f'\rLoading {ProgramName} [{bar}] {percentage} % ', end='', flush=False)
                        
                        time.sleep(delay)  # Pause to control the update rate
                print_loading_bar(50)
                os.system("bash localScript.sh")  # the script to run after loading
            
            else:    
                # makes a pop up dialog to tell the user that the user is not root
                print(f"TIME:{formatted_time} Please run as ROOT. DATE:{current_date}")
                print(f"ERROR:TIME:{formatted_time} Please run as ROOT. DATE:{current_date}", file=ERROR)
        else:
            # makes a pop up dialog to tell the user that the OS is not correct
            # makes a pop up dialog to tell the user that the OS is not correct
            print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
            print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)
    
    # tell the user to chose "GLOBAL", "LOCAL", "GUI", "HELP" to work correctly
    else:
        print("Please use the correct number of arguments.") 
        print(f"Example: {GLOBAL}, {LOCAL}, {GUI} or {HELP}")

# if the user uses control-c, the program will exit
except KeyboardInterrupt:
    print("\n[-] Exiting...")