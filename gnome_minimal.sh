#!/bin/bash

# Script: gnome_minimal.sh
# Description: Installs the minimal GNOME desktop environment on Debian.

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as sudoer. Use 'sudo ./gnome_minimal.sh'" 1>&2
    exit 1
fi

# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade

# Install the gnome-session package.
sudo apt install -y gnome-session

# Display a menu for additional packages.
echo "Do you want to install additional packages?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            # Install additional packages.
            sudo apt install -y nautilus gnome-terminal
            break;;
        No )
            echo "No additional packages will be installed."
            break;;
    esac
done

# Display a message indicating successful installation.
echo "GNOME minimal installation complete."

