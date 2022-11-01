import pyfiglet
from sys import platform
import pyfiglet
ascii_banner = pyfiglet.figlet_format("Hercules")
if platform == "linux":
    print(ascii_banner)
else:
    print(f"Wrong OS plase use the correct OS.")
