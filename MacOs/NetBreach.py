from DontEdit import *
from HelpLogo import *

# gets the current time and formats it HH:MM:SS
current_time = datetime.datetime.now().time()

#get the current time and formats it in the 12 hour format
formatted_time = current_time.strftime("%I:%M:%S %p")

# Get the current date
current_date = datetime.datetime.now().strftime("%m/%d/%Y")

ERROR = open("ERROR.log", "a")

ProgramName = "NetBreach"
SoftwareName = "NetBreach.py"  

#this is for the user to understand what the program does
def show_help():

    HelpFile = open("HELP.txt", "w")

    #This is for the user to know what programs are used in this program
    ProgramsUsed = f"+++++++++++++++PROGRAMS USED+++++++++++++++"
    ProgramsUsedInfo01 = f"\nThis program will help you crack passwords"
    ProgramsUsedInfo02 = f"\nIt has two programs inside it"
    ProgramsUsedInfo03 = f"\none is {GREEN}Hydra{RESET} and the other is {BLUE}Nmap{RESET} and"

    #this is for the user to understand what the program does
    HowToUse = f"\n+++++++++++++++HOW TO USE++++++++++++++++++"
    HowToUseInfo01 = f"\nTo use the program you have to tell the computer what port you want to scan."
    HowToUseInfo02 = f"\nIt will then scan the port that you asked for on the network and see if any ports that you asked are open."
    HowToUseInfo03 = f"\nIf there are any ports that are open, it will ask for a username and hostname"
    HowToUseInfo04 = f"\nWhen you give the program the username and hostname, it will try to crack that given parameters you gave it."
    HowToUseInfo05 = f"\nIf you want to use the program on a global network, you can type {GREEN}'sudo python3 {SoftwareName} {GLOBAL}'{RESET}"
    HowToUseInfo06 = f"\nIf you want to use the program with GUI support you can type {GREEN}'sudo python3 {SoftwareName} {GUI}'{RESET}" 
    HowToUseInfo07 = f"\nIf you want to use the program locally, you can type {GREEN}'python3 {SoftwareName} {LOCAL}'{RESET}"
    HowToUseInfo08 = f"\nIf you want to use the program with GUI in Local mode you can type {GREEN}'python3 {SoftwareName} {GuiLocal}'{RESET}"
    HowToUseInfo09 = f"\nIf you want to have the program install required packages by it's self type {GREEN}'python3 {SoftwareName} {installRequirement}'{RESET}"
    HowToUseInfo10 = f"\nIf you want to have the program uninstall required packages by it's self type {GREEN}'python3 {SoftwareName} {uninstallRequirement}'{RESET}"
    HowToUseInfo11 = f"\nIf you want to have the program allow you to input the ip address or website manually for global networks type {GREEN}'python3 {SoftwareName} {GlobalManualArgument}'{RESET}"
    HowToUseInfo12 = f"\nIf you want to have the program allow you to input the ip address or website manually for local networks type {GREEN}'python3 {SoftwareName} {LocalManualArgument}'{RESET}"
    HowToUseInfo13 = f"\nIf you get a error message you can type {GREEN}'python3 {SoftwareName} {FIX}'{RESET}"
    HowToUseInfo14 = f"\nIf you want to remote conenct to a computer type {GREEN}'python3 {SoftwareName} {conenctRDP}'{RESET}"
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
            HowToUseInfo05 +
            HowToUseInfo06 +
            HowToUseInfo07 +
            HowToUseInfo08 +
            HowToUseInfo09 +
            HowToUseInfo10 +
            HowToUseInfo11 +
            HowToUseInfo12 +
            HowToUseInfo13 +
            HowToUseInfo14) 

    lineArt(["figlet", f"{name}"])
    lineArt(["figlet", "? HELP ?"])
    print(NameOfOs,  file=HelpFile)
    print(HELP_LOGO, file=HelpFile)
    
    #inputs the program used logo in a help file
    #puts the info about the program inside the help file
    print(ProgramsUSED)
    print(info)
    #Puts the info logo in the help file
    print(ProgramsUSED, file=HelpFile)

    #puts the info about how to use the program inside the help file
    print(info, file=HelpFile)

    #puts the info about how to use the program on the screen

# fixes the program by finding the bug and fixing it
def fix():
    try:
        def check_files(file_paths):
            non_existent_files = [file for file in file_paths if not Path(file).exists()]
            return non_existent_files

        # checks if the file is in the computer or not
        file_paths = RemoveFile
        non_existent_files = check_files(file_paths)

        #if the file is no longer in the computer it says that the file no longer exists
        if non_existent_files:
            print("The Fix command has run and found no errors")
        # else if the file is still in the computer it says that the file still exists and removes it
        else:
            print("The following files still exist on your computer.")
            for file in file_paths:
                print(file)
            print("I will remove them for you.")
            os.remove(file)

    except subprocess.CalledProcessError as ERROR:
        print(f"Error: {ERROR}")
        sys.exit(1)
    
    except KeyboardInterrupt:
        print('\n[-] Exiting...')
        sys.exit(1)

#puts program in GUI mode
def Show_GUI():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # get the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False
    connect()
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
            subprocess.run(GuiScript)  # the script to run after loading
        else:    
            # makes a pop up dialog to tell the user that the user is not root
            print(f"[ {RED}FAIL{RESET} ] TIME:{formatted_time} Please run as ROOT. DATE:{current_date}")
            print(f"ERROR:TIME:{formatted_time} Please run as ROOT. DATE:{current_date}", file=ERROR)
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)

# puts it in GLOBAL mode
def show_GLOBAL():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    #gets the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

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
                    print(f'\rLoading {ProgramName} Globally [{bar}] {percentage} % ', end='', flush=False)
                    
                    time.sleep(delay)  # Pause to control the update rate
            print_loading_bar(50)
            subprocess.run(GlobalScript)  # the script to run after loading
        else:    
            # makes a pop up dialog to tell the user that the user is not root
            print(f"[ {RED}FAIL{RESET} ] TIME:{formatted_time} Please run as ROOT. DATE:{current_date}")
            print(f"ERROR:TIME:{formatted_time} Please run as ROOT. DATE:{current_date}", file=ERROR)
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)

# puts the program in LOCAL mode
def show_LOCAL():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # gets the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False

    # Makes sure that the user is connected to the internet    
    if platform.system() == OS:
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
                print(f'\rLoading {ProgramName} Locally [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        print(f"\n[ {GREEN}OK{RESET} ] Loading {ProgramName} complete")
        time.sleep(5)
        subprocess.run(LocalScript)  # the script to run after loading
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)

#puts the program into GUI LOCAL mode
def show_GuiLOCAL():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # get the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False

    # Makes sure that the user is connected to the internet    
    if platform.system() == OS:
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
                print(f'\rLoading {ProgramName} Locally [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        subprocess.run(GuiLocalScript)  # the script to run after loading
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)

#go to the manual for the Global mode
def show_manual_Global():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # get the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False

    # Makes sure that the user is connected to the internet    
    if platform.system() == OS:
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
                print(f'\rLoading {ProgramName} manually in global mode [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        subprocess.run(GlobalManual)  # the script to run after loading
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)

#go to the manual for the Local mode
def show_manual_Local():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # get the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False

    # Makes sure that the user is connected to the internet    
    if platform.system() == OS:
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
                print(f'\rLoading {ProgramName} manually in local mode [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        subprocess.run(LocalManual)  # the script to run after loading
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)
  
def RDPCONENCT():
    # gets the current time and formats it HH:MM:SS
    current_time = datetime.datetime.now().time()

    # get the current time and formats it in the 12 hour format
    formatted_time = current_time.strftime("%I:%M:%S %p")

    # Get the current date
    current_date = datetime.datetime.now().strftime("%m/%d/%Y")

    def connect(url="https://google.com"):
        try:
            urllib.request.urlopen(url)  # Try to open a connection to the host
            return True  # If successful, return True
        except:
            return False  # If unsuccessful, return False

    # Makes sure that the user is connected to the internet    
    if platform.system() == OS:
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
                print(f'\rLoading {ProgramName} in RDP mode [{bar}] {percentage} % ', end='', flush=False)
                
                time.sleep(delay)  # Pause to control the update rate
        print_loading_bar(50)
        subprocess.run(RDPconnect)  # the script to run after loading
    else:
        # makes a pop up dialog to tell the user that the OS is not correct
        # makes a pop up dialog to tell the user that the OS is not correct
        print(f"TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
        print(f"WARNING:TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}",file=ERROR)
  
#holds the if statements that connect to the functions for the program to work properly
try:
    # Handle command-line arguments
    if len(sys.argv) == 2:
        # gets the help function
        if argument[1] in HELP:
            show_help()

        #gets the gui funciton
        elif argument[1] in GUI:
            Show_GUI()

        #gets the global function
        elif argument[1] in GLOBAL:
            show_GLOBAL()
        
        #gets the local function
        elif argument[1] in LOCAL:
            show_LOCAL()

        #gets the gui local funciton
        elif argument[1] in GuiLocal:
            show_GuiLOCAL()

        #gets the fix funciton
        elif argument[1] in FIX:
            fix()
        
        #gets the global manual funciton
        elif argument[1] in GlobalManualArgument:
            show_manual_Global()

        #get the local manula fucnoitn
        elif argument[1] in LocalManualArgument:
            show_manual_Local()

        #conenct with RDP mode enabled
        elif argument[1] in conenctRDP:
            RDPCONENCT()

        #gets the install funciton
        elif argument[1] in installRequirement:
            terminalCommand("bash requirements.sh")
        
        #get the unisntall funciotn
        elif argument[1] in uninstallRequirement:
            terminalCommand("bash uninstall.sh")

    #if the user does not input the correct argument it tells them what arguments to use for it to work 
    else:
        print(f"WARNING:TIME:{formatted_time} Please use the correct number of arguments. DATE:{current_date}",file=ERROR)
        print(f"Please use the correct number of arguments.")
        print(f'''Example: 
{GLOBAL} put's it in global mode for attacking global networks, 
{GUI} put's it in GUI mode to attacking in GUI GLOBAL networks, 
{LOCAL} put's it in local mode for attacking local networks,
{GuiLocal} put's it in GUI LOCAL mode to attacking in GUI LOCAL networks,
{GlobalManualArgument} put's it in global manual mode that shows you how to use the program,
{LocalManualArgument} put's it in local manual mode that shows you how to use the program,
{installRequirement} put's it in install mode that install's the required packages,
{uninstallRequirement} put's it in uninstall mode that uninstall's the packages,
{conenctRDP} put's the program into RDP connection mode,
{FIX} put's it in fix mode that fixes the program,
{HELP} put's it in help mode so you understand what you are going to do with this program.''')

except KeyboardInterrupt:
    print("\n[-] Exiting...")