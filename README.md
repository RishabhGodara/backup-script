# Backup Script

This bash script creates a backup of a specified file or directory and uploads it to OneDrive(or other cloud services) using rclone.

## Prerequisites

- [rclone](https://rclone.org/)
- A configured rclone remote for OneDrive or any other cloud services . You have to change remote name in script according to yours.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/RishabhGodara/backup-script.git
   cd backup-script
2.Ensure that rclone is properly configured 
  ```bash
  rclone config
```
3.Run the script
  ```bash
./backup_script.sh

  
