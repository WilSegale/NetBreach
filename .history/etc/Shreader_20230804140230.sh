#!/bin/bash

# Set the desired length of the random string
length=10

# Generate a random string of alphanumeric characters
random_string=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | head -c "$length")

echo "Random string: $random_string"
