from DontEdit import *
from logo import *
try:
    ProgramName = "Hercules"

    OS='Darwin'

    GREEN = "\033[92m"
    RED = "\033[91m"
    RESET = "\033[0m"

    #this is for the user to understand what the program does
    if len(sys.argv) == 2 and sys.argv[1] == "--help" or len(sys.argv) == 2 and sys.argv[1] == "-h":
        HelpFile = open("HELP.txt", "w")

        #This is for the user to know what programs are used in this program
        ProgramsUsed = "+++++++++++++++Programs used+++++++++++++++"
        ProgramsUsedInfo = "This program will help you crack passwords \nIt has two programs inside it, one is Hydra and the other is Nmap"

        #this is for the user to understand what the program does
        HowToUse = "\n+++++++++++++++How to use++++++++++++++++++"
        HowToUseInfo01 = "To use the program you have to tell the computer what port you want to scan."
        HowToUseInfo02 = "\nIt will then scan the port that you asked for on the network and see if any ports that you asked are open."
        HowToUseInfo03 = "\nIf there are any ports that are open, it will ask for a username and hostname"
        HowToUseInfo04 = "\nWhen you give the program the username and hostname, it will try to crack that given parameters you gave it."
        ending = ""

        info = (HowToUseInfo01 +
                HowToUseInfo02 + 
                HowToUseInfo03 + 
                HowToUseInfo04 +
                ending)
        subprocess.run(["figlet", "? HELP ?"])

        print(text_art, file=HelpFile)
        print()
        #inputs the program used logo in a help file
        print(ProgramsUsed, file=HelpFile)

        #puts the info about the program inside the help file
        print(ProgramsUsedInfo, file=HelpFile)
        print(ProgramsUsed)
        print(ProgramsUsedInfo)
        print()

        #Puts the info logo in the help file
        print(HowToUse, file=HelpFile)

        #puts the info about how to use the program inside the help file
        print(info, file=HelpFile)
        #puts the info about how to use the program on the screen
        
        print(HowToUse)
        print(info)
        print()
    elif len(sys.argv) == 2 and sys.argv[1] == "--version" or len(sys.argv) == 2 and sys.argv[1] == "-v":
        print("Hercules v4.5.6")
    else:
        # gets the current time and formats it HH:MM:SS
        current_time = datetime.datetime.now().time()
        formatted_time = current_time.strftime("%I:%M:%S %p")

        # Get the current date
        current_date = datetime.datetime.now().strftime("%m/%d/%Y")

        # easy way to read the root user function
        ROOT = 0

        def connect(host="google.com"):
            try:
                urllib.request.urlopen("http://" + host)  # Try to open a connection to the host
                return True  # If successful, return True
            except:
                return False  # If unsuccessful, return False

        # Makes sure that the user is connected to the internet    
        if connect() == 1:  
            #checks if the user is on Mac OS
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
                    os.system("bash script.sh")  # Replace with your actual script to run after loading
                
                else:    
                    # makes a pop up dialog to tell the user that the user is not root
                    applescript_command = f'display dialog "TIME:{formatted_time} Please run as root. DATE:{current_date}" with title "|CRITICAL ERROR|"'
                    subprocess.run(['osascript', '-e', applescript_command])
            else:
                # makes a pop up dialog to tell the user that the OS is not correct
                applescript_command = f'display dialog "TIME:{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}" with title "WARNING"'
                subprocess.run(['osascript', '-e', applescript_command])
        else:
            os.system(f'zenity --error --title="|CRITICAL ERROR|" --text="TIME:{formatted_time} Please connect to the internet. DATE:{current_date}"')


except KeyboardInterrupt:
    print("\nExiting...")   