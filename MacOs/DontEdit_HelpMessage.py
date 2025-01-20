from DontEdit import *
#esay way to edit and change the help messages
#--------------HELP MESSAGE START with color-------------------#
#This is for the user to know what programs are used in this program
ProgramsUSEDCOLOR = f"+++++++++++++++PROGRAMS USED+++++++++++++++"
ProgramsUsedInfo01COLOR = f"\nThis program will help you crack passwords"
ProgramsUsedInfo02COLOR = f"\nIt has two programs inside it"
ProgramsUsedInfo03COLOR = f"\none is {GREEN}Hydra{RESET} and the other is {GREEN}Nmap{RESET}"

#this is for the user to understand what the program does
HowToUseColor = f"\n+++++++++++++++HOW TO USE++++++++++++++++++"
HowToUseInfo01Color = f"\nTo use the program you have to tell the computer what port you want to scan."
HowToUseInfo02Color = f"\nIt will then scan the port that you asked for on the network and see if any ports that you asked are open."
HowToUseInfo03Color = f"\nIf there are any ports that are open, it will ask for a username and hostname"
HowToUseInfo04Color = f"\nWhen you give the program the username and hostname, it will try to crack that given parameters you gave it."
HowToUseInfo05Color = f"\nIf you want to use the program on a global network, you can type {GREEN}'sudo python3 {SoftwareName} {GLOBAL}'{RESET}"
HowToUseInfo06Color = f"\nIf you want to use the program with GUI support you can type {GREEN}'sudo python3 {SoftwareName} {GUI}'{RESET}" 
HowToUseInfo07Color = f"\nIf you want to use the program locally, you can type {GREEN}'python3 {SoftwareName} {LOCAL}'{RESET}"
HowToUseInfo08Color = f"\nIf you want to use the program with GUI in Local mode you can type {GREEN}'python3 {SoftwareName} {GuiLocal}'{RESET}"
HowToUseInfo09Color = f"\nIf you want to have the program install required packages by it's self type {GREEN}'python3 {SoftwareName} {installRequirement}'{RESET}"
HowToUseInfo10Color = f"\nIf you want to have the program install required packages by it's self type {GREEN}'python3 {SoftwareName} {pipForce}'{RESET}"
HowToUseInfo11Color = f"\nIf you want to have the program uninstall required packages by it's self type {GREEN}'python3 {SoftwareName} {uninstallRequirement}'{RESET}"
HowToUseInfo12Color = f"\nIf you want to have the program allow you to input the ip address or website manually for global networks type {GREEN}'python3 {SoftwareName} {GlobalManualArgument}'{RESET}"
HowToUseInfo13Color = f"\nIf you want to have the program allow you to input the ip address or website manually for local networks type {GREEN}'python3 {SoftwareName} {LocalManualArgument}'{RESET}"
HowToUseInfo14Color = f"\nIf you get a error message you can type {GREEN}'python3 {SoftwareName} {FIX}'{RESET}"
HowToUseInfo15Color = f"\nIf you want to remote conenct to a computer type {GREEN}'python3 {SoftwareName} {conenctRDP}'{RESET}"
HowToUseInfo16Color = f"\nIf you want to skip a step type {GREEN}'sudo python3 {SoftwareName} {skipGlobal}'{RESET}"
HowToUseInfo17Color = f"\nIf you want to skip a step type {GREEN}'python3 {SoftwareName} {skipLocal}'{RESET}"

ProgramsUSEDCOLOR = (ProgramsUSEDCOLOR+
                ProgramsUsedInfo01COLOR+
                ProgramsUsedInfo02COLOR+
                ProgramsUsedInfo03COLOR)

# holds the information about how the program works in a array so it can grab them more easily
InfoColor = (HowToUseColor +
        HowToUseInfo01Color +
        HowToUseInfo02Color + 
        HowToUseInfo03Color + 
        HowToUseInfo04Color +
        HowToUseInfo05Color +
        HowToUseInfo06Color +
        HowToUseInfo07Color +
        HowToUseInfo08Color +
        HowToUseInfo09Color +
        HowToUseInfo10Color +
        HowToUseInfo11Color +
        HowToUseInfo12Color +
        HowToUseInfo13Color +
        HowToUseInfo14Color +
        HowToUseInfo15Color +
        HowToUseInfo16Color + 
        HowToUseInfo17Color)
#--------------HELP MESSAGE END with color-------------------#

#--------------HELP MESSAGE START-------------------#

#This is for the user to know what programs are used in this program

ProgramsUSED = f"+++++++++++++++PROGRAMS USED+++++++++++++++"
ProgramsUsedInfo01 = f"\nThis program will help you crack passwords"
ProgramsUsedInfo02 = f"\nIt has two programs inside it"
ProgramsUsedInfo03 = f"\none is Hydra and the other is Nmap and"

#this is for the user to understand what the program does
HowToUse = f"\n+++++++++++++++HOW TO USE++++++++++++++++++"
HowToUseInfo01 = f"\nTo use the program you have to tell the computer what port you want to scan."
HowToUseInfo02 = f"\nIt will then scan the port that you asked for on the network and see if any ports that you asked are open."
HowToUseInfo03 = f"\nIf there are any ports that are open, it will ask for a username and hostname"
HowToUseInfo04 = f"\nWhen you give the program the username and hostname, it will try to crack that given parameters you gave it."
HowToUseInfo05 = f"\nIf you want to use the program on a global network, you can type 'sudo python3 {SoftwareName} {GLOBAL}'"
HowToUseInfo06 = f"\nIf you want to use the program with GUI support you can type 'sudo python3 {SoftwareName} {GUI}'" 
HowToUseInfo07 = f"\nIf you want to use the program locally, you can type 'python3 {SoftwareName} {LOCAL}'"
HowToUseInfo08 = f"\nIf you want to use the program with GUI in Local mode you can type 'python3 {SoftwareName} {GuiLocal}'"
HowToUseInfo09 = f"\nIf you want to have the program install required packages by it's self type'python3 {SoftwareName} {installRequirement}'"
HowToUseInfo10 = f"\nIf you want to have the program install required packages by it's self type 'python3 {SoftwareName} {pipForce}'"
HowToUseInfo11 = f"\nIf you want to have the program uninstall required packages by it's self type 'python3 {SoftwareName} {uninstallRequirement}'"
HowToUseInfo12 = f"\nIf you want to have the program allow you to input the ip address or website manually for global networks type 'python3 {SoftwareName} {GlobalManualArgument}'"
HowToUseInfo13 = f"\nIf you want to have the program allow you to input the ip address or website manually for local networks type 'python3 {SoftwareName} {LocalManualArgument}'"
HowToUseInfo14 = f"\nIf you get a error message you can type 'python3 {SoftwareName} {FIX}'"
HowToUseInfo15 = f"\nIf you want to remote conenct to a computer type 'python3 {SoftwareName} {conenctRDP}'"
HowToUseInfo16 = f"\nIf you want to skip a step type 'sudo python3 {SoftwareName} {skipGlobal}'"
HowToUseInfo17 = f"\nIf you want to skip a step type 'python3 {SoftwareName} {skipLocal}'"

ProgramsUSED = (ProgramsUSED+
                ProgramsUsedInfo01+
                ProgramsUsedInfo02+
                ProgramsUsedInfo03)

# holds the information about how the program works in a array so it can grab them more easily
Info = (HowToUse +
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
        HowToUseInfo14 +
        HowToUseInfo15 +
        HowToUseInfo16 +
        HowToUseInfo17)
#--------------HELP MESSAGE END-------------------#



#place to esaly edit and change the warning message are error log
ErrorMessage = f'''WARNING:TIME:{formatted_time} Please use the correct number of arguments. DATE:{current_date}'''
explain = f'''
Please use the correct number of arguments. Example: 
{GLOBAL} put's it in global mode for attacking global networks, 
{GUI} put's it in GUI mode to attacking in GUI GLOBAL networks, 
{LOCAL} put's it in local mode for attacking local networks,
{GuiLocal} put's it in GUI LOCAL mode for attacking in GUI LOCAL networks,
{GlobalManualArgument} put's it in global manual mode that shows you how to use the program,
{LocalManualArgument} put's it in local manual mode that shows you how to use the program,
{installRequirement} put's it in install mode that install's the required packages,
{pipForce} put's it in pipForce mode that installs the required packages with pipForce,
{uninstallRequirement} put's it in uninstall mode that uninstall's the packages,
{conenctRDP} put's the program into RDP connection mode,
{autoConnect} put's the program into auto connect, if there is a file with the user SSH username and ip address to use,
{FIX} put's it in fix mode that fixes the program,
{skipGlobal} put's it in skip global mode that skips the global mode,
{skipLocal} put's it in skip local mode that skips the local mode,
{HELP} put's it in help mode so you understand what you are going to do with this program.'''
