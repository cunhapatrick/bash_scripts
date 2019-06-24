#!/bin/bash

#Set name
NAME=$(basename $0)

#Set option choices
OPTS="h12345"
PUSAGE=""

#This is how to use the script
usage="
Hello, "$USER".  This script will allow you to start the following. 
You can run as many as you like starting with a '-'.  Example below.

Usage:  ${NAME} [OPTIONS]

Options are:
  -h  Show this message.
  -1. Install latest nodejs
  -2. Install latest yarn
  -3. Install latest create-react-app
  -4. Install latest react-native-cli
  -5. Install latest docker-cli

Example:

${NAME} -134
"

#Run script
while getopts :${OPTS} i ; do
    case $i in
    1) 
      echo "Updating system..."
      sudo apt update
      echo "Downloading nodejs"
      sudo apt install nodejs npm
      echo "Finish process, the nodejs is installed, see the version below!"
      nodejs --version
    2)
      echo "Installing Curl if not installed already"
      sudo apt install curl
      echo "Adding yarn gpg key"
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "Adding yarn repository to the system"
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      echo "Updating system repositories..."
      sudo apt update
      echo "Installing Yarn..."
      sudo apt install yarn
      echo "Installation finished, see the version below!"
      yarn --version
    3)
      echo "Global create-react-app installation"
      yarn global add create-react-app
      echo "Installation complete, see the version below!"
      create-react-app --version
    4)
      echo "Global react-native cli installation"
      yarn global add react-native-cli
      echo "Installation complete, see the version below!"
      react-native --version
    5)
      echo "Updating system repositories..."
      sudo apt update
      echo "Installing pre-required apt packages"
      sudo apt install apt-transport-https ca-certificates curl software-properties-common
      echo "Installing GPG docker repository key"
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      echo "Adding docker repository to system"
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
      echo "Updating system"
      sudo apt update
      echo "Installing docker cli"
      sudo apt install docker-ce
      echo "Adding username to docker group"
      sudo usermod -aG docker ${USER}
      echo "Applying the new association"
      su - ${USER}
      echo "Docker installation complete, see the version below!"
      docker version
    h | \?) PUSAGE=1;;
    esac
done

#Show help based on selection
if [ ${PUSAGE} ]; then
    echo "${usage}"
    exit 0
fi

#Check for input if none show help.
if [[ $1 == "" ]]; then
    echo "${usage}"
    exit 0
fi