#!/bin/bash

FILE="$1"

# Check if an argument (file path) is provided
if [ -z "$FILE" ]; then
    zenity --error --text="No file provided." --title="Error"
    exit 1
fi

# Check if the file exists
if [ ! -f "$FILE" ]; then
    zenity --error --text="File does not exist: $FILE" --title="Error"
    exit 1
fi

# Read the content of the file
FILE_CONTENT=$(cat "$FILE")

# If the content is ".", proceed with folder picker
if [ "$FILE_CONTENT" == "." ]; then
    # Open folder picker with Zenity
    SELECTED_FOLDER=$(zenity --file-selection --directory --title="Select a folder to link")
    
    # Check if a folder was selected
    if [ -z "$SELECTED_FOLDER" ]; then
        zenity --error --text="No folder selected." --title="Error"
        exit 1
    fi

    # Apply the sed transformations
    MODIFIED_PATH=$(echo "$SELECTED_FOLDER" | sed 's|/var/home/[^/]*|${HOME}|g' | sed 's|/home/[^/]*|${HOME}|g')
    
    # Store the modified path back into the file, overwriting its content
    echo -n "$MODIFIED_PATH" > "$FILE"
    
    # Display success message
    zenity --info --text="Folder Linked. Click again to open it." --title="Success"
    exit 0
else
    # If the content is not ".", treat it as a path
    if [ -n "$FILE_CONTENT" ]; then
        # Expand any environment variables in the file content
        EXPANDED_PATH=$(eval echo "$FILE_CONTENT")
        
        # Open the expanded path with xdg-open
        xdg-open "$EXPANDED_PATH"
        exit 0
    else
        zenity --error --text="Invalid file content. Cannot open." --title="Error"
        exit 1
    fi
fi
