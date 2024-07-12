#!/bin/bash

# Check if rclone is installed
if ! command -v rclone > /dev/null; then
  echo "rclone is not installed. Please install rclone first and set up account."
  exit 1
fi

# Variables
REMOTE_NAME="onedrive"            # rclone remote configuration name 
REMOTE_DIR="backup"               # Remote directory on OneDrive 
LOGFILE="$HOME/backup_script.log" # Log file for script execution details
DATE=$(date +%F)                  # Current date for timestamping the backup

# Function to create backup and upload to cloud
backup() {
   local input_path="$1"
   local base_name=$(basename "$input_path")   # Get the base name

  if [ -d "$input_path" ]; then
    # If it's a directory, create a compressed archive
    tar -czf /tmp/$backup_name-$DATE.tar.gz $base_name
    rclone copy /tmp/$backup_name-$DATE.tar.gz $REMOTE_NAME:$REMOTE_DIR
    rm /tmp/$backup_name-$DATE.tar.gz
  elif [ -f "$input_path" ]; then
    # If it's a file, then copy it
    rclone copy "$backup_name" $REMOTE_NAME:$REMOTE_DIR
  else
    echo "Invalid input path: $input_path" 
    exit 1
  fi

  if [ $? -eq 0 ]; then
    echo "Backup and upload of $input_path to $REMOTE_NAME:$REMOTE_DIR completed on $DATE" 
  else
    echo "Backup and upload of $input_path to $REMOTE_NAME:$REMOTE_DIR failed on $DATE" >> $LOGFILE
  fi
}

# Main script logic
echo "Enter the path of the file or directory to back up:"
read input_path

if [ -z "$input_path" ]; then
  echo "No input provided. Exiting."
  exit 1
fi

backup "$input_path"
