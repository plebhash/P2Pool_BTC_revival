#!/bin/bash

echo "This script is about to pkill bitcoind. Do you want to continue? (yes/no)"
read -r user_input

if [ "$user_input" != "yes" ]; then
  echo "User did not consent. Exiting."
  exit 1
fi

sudo pkill bitcoind

# Get the current date in YYYY-MM-DD format
DATE=$(date +%F)

# Define the tarball name
TARBALL="snapshot_$DATE.tar.gz"

# Define the directories to include in the tarball
DIR1="$HOME/.bitcoin/chainstate"
DIR2="$HOME/.bitcoin/blocks"

# Check if the directories exist
if [ ! -d "$DIR1" ]; then
    echo "Directory $DIR1 does not exist. Exiting."
    exit 1
fi

if [ ! -d "$DIR2" ]; then
    echo "Directory $DIR2 does not exist. Exiting."
    exit 1
fi

# Create the tarball
tar -czf "$TARBALL" -C "$HOME/.bitcoin" chainstate blocks

# Check if the tarball was created successfully
if [ $? -eq 0 ]; then
    echo "Snapshot created successfully: $TARBALL"
else
    echo "Failed to create snapshot. Exiting."
    exit 1
fi

