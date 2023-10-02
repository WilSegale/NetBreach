#!/bin/bash

# Define the total number of steps for your loading process
total_steps=100

(
  # Start a subshell to redirect the output
  for ((step = 0; step <= total_steps; step++)); do
    # Calculate the percentage completed
    percentage=$((step * 100 / total_steps))
    
    # Update the Zenity progress bar and percentage
    echo "$percentage"
    echo "# Processing... $percentage%"

    # Simulate some work (you can replace this with your actual task)
    sleep 0.1
  done
) | zenity --progress --auto-close --title="Loading Bar" --text="Starting..." --percentage=0

# Display a completion message
zenity --info --title="Loading Bar" --text="Process completed successfully!"

