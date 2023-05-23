#!/bin/bash

package_name="stegcracker"

# Use pip show command to check if the package is installed
pip show "$package_name" > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "$package_name is installed."
else
  echo "$package_name is not installed."
fi
