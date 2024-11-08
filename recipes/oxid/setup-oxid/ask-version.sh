#!/bin/bash
# Display options to the user
echo "Please select an option:"
echo "1) 6.5"
echo "2) 7.0"

# Read user input
read -p "Enter the number corresponding to your choice (1 or 2): " choice

# Save the choice in a variable based on the user's input
if [ "$choice" == "1" ]; then
    selected_version="6.5"
elif [ "$choice" == "2" ]; then
    selected_version="7.0"
else
    echo "Invalid selection. Please run the script again and choose 1 or 2."
    exit 1
fi

# Display the selected version
echo "You selected version: $selected_version"
