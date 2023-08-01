#!/usr/bin/env python3

import os
import shutil
import time

def copy_files(source_folder, destination_folder):
    # Get the list of files in the source folder
    source_files = os.listdir(source_folder)

    # Get the list of files in the destination folder
    destination_files = os.listdir(destination_folder)

    # Check for redundancy and copy only new files
    for file in source_files:
        source_path = os.path.join(source_folder, file)
        destination_path = os.path.join(destination_folder, file)

        if file not in destination_files:
            shutil.copy2(source_path, destination_path)
            print(f"Copying {file} to the backup folder.")

            # Get the UID and GID of the current user
            uid = os.getuid()
            gid = os.getgid()

            # Set the ownership of the copied file to the current user
            os.chown(destination_path, uid, gid)

def main():
    source_folder = "/home/jd/Pictures/GoogleEarthWallpaper"
    destination_folder = "/home/jd/Pictures/GEarthWP_Backup"

    while True:
        try:
            copy_files(source_folder, destination_folder)
            time.sleep(600)  # 600 seconds = 10 minutes
        except KeyboardInterrupt:
            print("\nProgram terminated by the user.")
            break
        except Exception as e:
            print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
