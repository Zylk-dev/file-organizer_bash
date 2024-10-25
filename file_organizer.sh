#!/bin/bash

# Function to display the directory structure
list_directories() {
    echo "==========================================="
    echo "            Directories                   "
    echo "==========================================="
    # Use tree command to display directories
    tree -d -C
    echo ""
    echo "Now that’s a directory I can follow! 🗂️"
    echo ""
}

# Function to display files in a tree-like format
list_files_by_type() {
    echo "==========================================="
    echo "            Files by Type                 "
    echo "==========================================="

    # Create an associative array to hold file types
    declare -A file_types

    # Find files and categorize them by extension, including hidden files
    for file in .* *; do
        # Skip directories
        if [[ -d $file ]]; then
            continue
        fi

        # Get the file extension
        ext="${file##*.}"

        # If the file doesn't have an extension, categorize it as "No Extension"
        if [[ "$file" == "$ext" ]]; then
            ext="No Extension"
        fi

        # Append the file to the corresponding array entry
        file_types["$ext"]+="$file"$'\n'
    done

    # Print the categorized files
    for ext in "${!file_types[@]}"; do
        echo "Files of Type: $ext"
        echo "-------------------------------------------"
        echo -e "${file_types[$ext]}" | sort
        echo ""
    done

    echo "Looks like we have some wild files without a type! 🐾"
    echo ""
}

# Function to display files in tree format
list_files_in_tree_format() {
    echo "==========================================="
    echo "          Files Tree Structure            "
    echo "==========================================="
    # Use tree command to display all files and directories
    tree -C
    echo ""
}

# Function to display the signature
display_signature() {
    cat << "EOF"
__________       .__   __                 .___           
\____    /___.__.|  | |  | __           __| _/_______  __
  /     /<   |  ||  | |  |/ /  ______  / __ |/ __ \  \/ /
 /     /_ \___  ||  |_|    <  /_____/ / /_/ \  ___/\   / 
/_______ \/ ____||____/__|_ \         \____ |\___  >\_/  
        \/\/               \/              \/    \/       
EOF
}

# Main menu function
main_menu() {
    while true; do
        echo "==========================================="
        echo "           File Organizer Menu            "
        echo "==========================================="
        echo "1. List Directories"
        echo "2. List Files by Type"
        echo "3. List All Files and Directories in Tree Format"
        echo "4. Exit"
        echo ""
        read -p "Choose an option [1-4]: " option

        case $option in
            1)
                list_directories
                display_signature  # Display signature after listing directories
                ;;
            2)
                list_files_by_type
                display_signature  # Display signature after listing files
                ;;
            3)
                list_files_in_tree_format
                display_signature  # Display signature after showing tree format
                ;;
            4)
                echo "Exiting... Thanks for stopping by! Don’t let the files bite! 🐍"
                exit  # Exit without displaying the signature again
                ;;
            *)
                echo "Invalid option. Please try again. It’s not rocket science! 🚀"
                ;;
        esac
    done
}

# Run the main menu
main_menu
