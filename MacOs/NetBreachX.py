from DontEdit import *
from DontEdit_HelpMessage import *
#this is for the user to understand what the program does
def show_help():

    HelpFile = open("HELP.txt", "w")

    lineArt(["figlet", f"{name}"])
    lineArt(["figlet", "? HELP ?"])
    
    # Open a file and print its content
    file_path = 'HelpLogo.txt'

    with open(file_path, 'r') as file:
        content = file.read()
    print(content,file=HelpFile)

    
    #inputs the program used logo in a help file
    #puts the info about the program inside the help file
    print(ProgramsUSEDCOLOR)
    print(InfoColor)

    #Puts the info logo in the help file
    print(ProgramsUSED, file=HelpFile)

    #puts the info about how to use the program inside the help file
    print(Info, file=HelpFile)

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

    def connect(url="8.8.8.8"):
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

# go to the RDP CONNECTION mode
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
            sys.exit()

        #gets the gui funciton
        elif argument[1] in GUI:
            Show_GUI()
            sys.exit()

        #gets the global function
        elif argument[1] in GLOBAL:
            show_GLOBAL()
            sys.exit()

        #gets the local function
        elif argument[1] in LOCAL:
            show_LOCAL()
            sys.exit()

        #gets the gui local funciton
        elif argument[1] in GuiLocal:
            show_GuiLOCAL()
            sys.exit()

        #gets the global manual funciton
        elif argument[1] in GlobalManualArgument:
            show_manual_Global()
            sys.exit()

        #get the local manula fucnoitn
        elif argument[1] in LocalManualArgument:
            show_manual_Local()
            sys.exit()

        #conenct with RDP mode enabled
        elif argument[1] in conenctRDP:
            RDPCONENCT()
            sys.exit()

        #gets the fix funciton
        elif argument[1] in FIX:
            fix()
            sys.exit()
    
        #enables the pipForce mode if pip3 install fails
        elif argument[1] in pipForce:
            terminalCommand("bash requirements.sh --pipForce")
            sys.exit()
        
        #gets the install funciton
        elif argument[1] in installRequirement:
            terminalCommand("bash requirements.sh")
            sys.exit()
        
        #get the unisntall function
        elif argument[1] in uninstallRequirement:
            terminalCommand("bash uninstall.sh")
            sys.exit()
        
        #skips the packages if one doents install for global
        elif argument[1] in skipGlobal:
            terminalCommand("bash GlobalScript.sh --skip-global")
            sys.exit()

        #skips the packages if one doents install for local
        elif argument[1] in skipLocal:
            terminalCommand("bash localScript.sh --skip-local")
            sys.exit()

        elif argument[1] in autoConnect:
            terminalCommand("bash GlobalScript.sh --auto")
            sys.exit()
        else:
            print(f'''{ErrorMessage} {explain}''', file=ERROR)
            print(f'''{RED}{ErrorMessage}{RESET} {explain}''')
    #if the user does not input the correct argument it tells them what arguments to use for it to work 
    else:
        
        print(f'''{ErrorMessage} {explain}''', file=ERROR)
        print(f'''{RED}{ErrorMessage}{RESET} {explain}''')
#holds the keyboard exit function
except KeyboardInterrupt:
    print("\n[-] Exiting...")