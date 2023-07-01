#!/bin/bash

script_file="/path/to/your/script.sh"
search_line="export HOMEBREW_INSTALL_FROM_API=1"

if grep -Fxq "$search_line" "$script_file"; then
    echo "The line '$search_line' exists in the script file."
else
    echo "The line '$search_line' does not exist in the script file."
fi
