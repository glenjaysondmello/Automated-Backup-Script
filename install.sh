#!/bin/bash

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="autobackup"
SCRIPT_PATH="${pwd}/menu.sh"

sudo ln -sf "$SCRIPT_PATH" "$INSTALL_DIR/$SCRIPT_NAME"

echo "AutoBackup Pro installed as command: $SCRIPT_NAME"
echo "Now you can run 'autobackup' from anywhere."