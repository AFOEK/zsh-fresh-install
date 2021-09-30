#!/bin/bash
platform='unknow'
unamestr=$(uname)
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release > /dev/null 2>&1; then
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe_version ]; then
    OS=SuSe
    VER=$(cat /etc/SuSe_version)
elif [ -f /etc/redhat_version ]; then
    OS=RedHat
    VER=$(cat /etc/redhat_version)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ "$OS" == "Ubuntu" ]]; then
    sudo apt-get install -y zsh wget git lolcat figlet
elif [[ "$OS" == "Darwin" ]]; then
    if ! [ -x "$(command -v brew)" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    sudo brew install lolcat figlet