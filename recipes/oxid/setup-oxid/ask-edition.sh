#!/bin/bash
# Display options to the user
echo "Please select the edtion:"
echo "1) ce"
echo "2) pe"
echo "3) ee"

# Read user input
read -p "Enter the number corresponding to your choice (1, 2 or 3): " choice

# Save the choice in a variable based on the user's input
if [ "$choice" == "1" ]; then
    selected_edition="ce"
elif [ "$choice" == "2" ]; then
    selected_edition="pe"
elif [ "$choice" == "3" ]; then
    selected_edition="ee"
else
    echo "Invalid selection. Please run the script again and choose 1, 2 or 3."
    exit 1
fi

# Display the selected edtion
echo "You selected edtion: $selected_edition"
