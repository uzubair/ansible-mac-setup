#!/usr/bin/env sh
# This script installs the required dependencies on the target machine  
# Usage: ./ansible_setup.sh
#
# NOTE: Not to be run with sudo
echo "!!! Starting initial setup !!!"

# installs the xcode command line tools
function install_xcode() {
  echo "\nInstalling xcode command line tools..."
  sudo xcode-select --install
  sleep 2
  osascript <<EOD
    tell application "System Events"
      tell process "Install Command Line Developer Tools"
        keystroke return
        delay 3
        click button "Agree" of window "License Agreement"
      end tell
    end tell
EOD
  if [ $? -ne 0 ]; then
      echo "Failed to install xcode command line tools"
      exit 1
  fi
}

# installs pip
function install_pip() {
  echo "\nChecking if pip is already installed..."
  if [[ ! `which pip` ]]; then
    echo "Installing pip..."
    sudo easy_install pip
  else
    echo "pip is already installed. Upgrading..."
    sudo pip install --upgrade pip
    if [[ $? -ne 0 ]]; then
      echo "Failed to upgrade pip..."
    fi
  fi
}

# installs homebrew and set permissions
function install_brew() {
  echo "\nChecking if homebrew is already installed..."
  if [[ ! `which brew` ]]; then
    echo "Installing homebrew..."
    yes | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "Homebrew is already installed..."
  fi

  echo ""
  echo "Tapping brew"
  brew tap homebrew/services
  brew tap caskroom/cask

  echo ""
  echo "Configuring homebrew to allow multiple users"

  # allow admins to manage homebrew
  chgrp -R admin /usr/local
  chmod -R g+w /usr/local

  # allow admins to manage local cache
  chgrp -R admin /Library/Caches/Homebrew
  chmod -R g+w /Library/Caches/Homebrew

  # allow admins to manage cask installs
  chgrp -R admin /opt/homebrew-cask
  chmod -R g+w /opt/homebrew-cask
}

# installs requirements
function install_requirements() {
  echo "\nInstalling requirements using pip..."
  sudo pip install -r requirements.txt
}

# script startup...
install_xcode
install_pip
install_brew
install_requirements

echo "!!! Completed !!!"
