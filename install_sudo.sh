#!/bin/bash

# Script: install_sudo.sh
# Description: Installs the Sudo Package and configure on Debian.

# Function to wait for user input.
press_enter_to_continue() {
    echo "Press Enter to continue..."
    read -r
}

# Function to clear the screen with a 3-second pause.
clear_screen() {
    sleep 3
    clear
}

# Function to display a colored message based on success or failure.
display_message() {
    if [ "$1" -eq 0 ]; then
        sleep 1
        echo -e "\e[32m$2\e[0m"  # Success message in green
    else
        sleep 1
        echo -e "\e[31m$3\e[0m"  # Failure message in red
        exit 1
    fi
}

clear_screen
echo "To install the 'sudo' package you will need root access"
sleep 1
echo "Note: To install 'sudo' package, it is necessary to restart your system after installation."
sleep 1
echo "Do you want to continue with the installation? (Y/n)"
read -r install_choice
if [ "$install_choice" = "Y" ] || [ "$install_choice" = "y" ] || [ "$install_choice" = "Yes" ] || [ "$install_choice" = "yes" ]; then
    su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
    display_message 0 "Installed successfully" "Failed to install. Exiting..."
else
    echo -e "\e[31mExiting the script.\e[0m"
    exit 1
fi
clear_screen
echo -e "\e[32mSudo package installed successfully!\e[0m"
sleep 1
echo "You may need to restart your system for changes to take effect."
sleep 1
echo "Do you want to reboot the system? (Y/n)"
read -r reboot_choice
if [ "$reboot_choice" = "Y" ] || [ "$reboot_choice" = "y" ] || [ "$reboot_choice" = "Yes" ] || [ "$reboot_choice" = "yes" ]; then
    echo 'Rebooting system now'
    sleep 2
    reboot
else
    exit 0
fi
