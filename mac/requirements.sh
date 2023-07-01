# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color


export HOMEBREW_INSTALL_FROM_API=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/admin/.zprofile eval "$(/opt/homebrew/bin/brew shellenv)"

Packages=(
   "wget"
   "hydra"
   "nmap"
   "mysql"
   "figlet"
)

pipPackages=(
   "tqdm"
   "asyncio"
   "colorama"
)

f

python3.10 -m pip install --upgrade pip