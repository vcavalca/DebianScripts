#!/usr/bin/env bash

# Install packages after installing base Debian with no GUI

# Update and Upgrade System
sudo apt update && sudo apt upgrade -y

# Torrent App
sudo apt install qbittorrent -y

# CPU-X App
sudo apt install cpu-x -y
