#!/bin/bash

# Set the total number of steps
total_steps=100

# Start Zenity progress bar
(
  for ((step = 1; step <= total_steps; step++)); do
    # Calculate the percentage completed
    percentage=$(( (step * 100) / total_steps ))

    # Update the progress bar
    echo "${percentage}"
    sleep 0.1  # Add a small delay to simulate progress

    # Check for cancellation (user clicks Cancel button)
    if [ "$?" != "0" ]; then
      echo "Cancelled!"
      exit 1
    fi
  done
) | zenity --progress --title="Loading" --text="Please wait..." --percentage=0 --auto-close

# Check the exit status of the progress bar
if [ "$?" = "0" ]; then
  # Completed successfully
  zenity --info --title="Done" --text="Loading is complete!"
else
  # User canceled
  zenity --info --title="Cancelled" --text="Loading was cancelled."
fi

