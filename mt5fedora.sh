#!/bin/bash

# MetaTrader download url
URL="https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe"

# get fedora Version for repo retrival
FEDORA_VER=$(rpm -E %fedora)
# Choose the appropriate URL based on Fedora version
if (( $FEDORA_VER >= 37 )); then
  dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/37/winehq.repo
elif (( $FEDORA_VER >= 38 )); then
  dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/38/winehq.repo
# Add more version checks here
else
  echo "Unsupported Fedora version"
  exit 1
fi

# Install required packages
sudo dnf install -y wine wine-mono wine-devel

# Download MetaTrader
wget $URL

# Set environment to Windows 10
WINEPREFIX=~/.mt5 winecfg

# Download MetaTrader
wget $URL -P ~/.mt5

# Install MetaTrader using Wine
WINEPREFIX=~/.mt5 wine ~/.mt5/mt5setup.exe

