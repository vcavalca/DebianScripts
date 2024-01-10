#!/bin/bash

# Script: main_script.sh
# Description: Main script for automating tasks on the system.

# Function to wait for user input.
press_enter_to_continue() {
    echo "Press Enter to continue..."
    read -r
}

# Function to check if sudo is installed.
check_sudo_installed() {
    if command -v sudo &> /dev/null; then
        echo "sudo is already installed."
    else
        echo "sudo is not installed. Do you want to install it? (Y/n)"
        read -r install_choice
        if [ "$install_choice" = "Y" ] || [ "$install_choice" = "y" ] || [ "$install_choice" = "Yes" ] || [ "$install_choice" = "yes" ]; then
            echo "Installing sudo..."
            sleep 1
            press_enter_to_continue
            ./install_sudo.sh
        else
            echo "Skipping sudo installation. Some tasks may require sudo privileges."
        fi
    fi
}

# Check if sudo is installed.
check_sudo_installed

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    clear_screen
    echo "This script must be run as a superuser. Use 'sudo ./gnome_minimal.sh'" 1>&2
    press_enter_to_continue
    exit 1
fi

# Display a menu for desktop environment packages.
clear_screen
echo "Which graphical environment do you want to install??"
press_enter_to_continue
select yn in "GNOME" "XFCE4"; do
    case $yn in
        GNOME )
            # Installs the minimal GNOME desktop environment
            sleep 1
            sudo ./gnome_minimal.sh
            break;;
        XFCE4 )
            # Installs the minimal XFCE4 desktop environment
            sleep 1
            sudo ./xfce4_minimal.sh
            break;;
    esac
done

# Display a menu for Internet Browser packages.
clear_screen
echo "Which Internet Browser do you want to install??"
press_enter_to_continue
select yn in "Brave" "Tor"; do
    case $yn in
        Brave )
            # Installs the Brave Browser
            sleep 1
            sudo ./install_brave.sh
            break;;
        Tor )
            # Installs the Tor Browser
            sleep 1
            sudo ./install_tor.sh
            break;;
    esac
done

# End of main script.
