#!/bin/bash

source .env

while true; do
    CHOICE=$(whiptail --title "AutoBackup Pro Menu" --menu "Choose an option" 20 60 10 \
        "1" "Run Backup" \
        "2" "Restore Backup" \
        "3" "View Backup Log" \
        "4" "Exit" \
        3>&1 1>&2 2>&3)

    exitStatus=$?

    if [ $exitStatus -ne 0 ]; then
        echo "User canceled."
        exit
    fi

    case $CHOICE in
        1)
            bash autoBackup.sh
            whiptail --title "Backup Status" --msgbox "Backup completed (check terminal output/log file)." 10 50
            ;;
        2)
            bash restore.sh
            whiptail --title "Restore Status" --msgbox "Restore completed (check terminal output/log file)." 10 50
            ;;
        3)
            whiptail --textbox "$LOG_FILE" 25 80
            ;;
        4)
            break
            ;;
        *)
            whiptail --msgbox "Invalid Option" 10 30
            ;;
    esac
done
