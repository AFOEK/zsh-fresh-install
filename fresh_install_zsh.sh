#!/bin/bash
platform='unknow'
unamestr=$(uname)
arch=$(uname -m)
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
elif command -v termux-setup-storage; then
    OS=termux
    VER=null
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ "$OS" == "Ubuntu" || "$OS" == "Debian" ]]; then
    sudo apt-get install -y zsh wget git lolcat figlet neofetch exa
elif [[ "$OS" == "Darwin" ]]; then
    if ! [ -x "$(command -v brew)" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    sudo brew install lolcat figlet exa neofetch
elif [[ "$OS" == "ManjaroLinux" ]]; then
    sudo pacman -Syu zsh lolcat figlet exa neofetch
elif [[ "$OS" == "termux" ]]; then
    pkg install zsh wget git figlet neofetch exa ruby
    gem install lolcat
fi
echo -e "\033[33mInstalling...\033[0m" && sleep 5
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ "$OS" == "Ubuntu" ]]; then
    cp zshrc_ubuntu $HOME/.zshrc
elif [[ "$OS" == "Darwin" ]]; then
    cp zshrc_darwin $HOME/.zshrc
elif [[ "$OS" == "ManjaroLinux" ]]; then
    cp zshrc_manjaro $HOME/.zshrc
elif [ "$OS" -eq "Debian" ] && { [ "$arch" -eq "x86_64" ] && [ "$arch" -eq "x86" ]; }; then 
    cp zshrc_debian $HOME/.zshrc
elif [ "$OS" -eq "Debian" ] && { [ "$arch" -eq "armv7l" ] && [ "$arch" -eq "aarch64" ]; }; then
    cp zshrc_raspberry $HOME/.zshrc
elif [ "$OS" -eq "termux" ] && { [ "$arch" -eq "armv7l" ] && [ "$arch" -eq "aarch64" ]; }; then
    cp zshrc_android_termux $HOME/.zshrc
else
    echo "Cannot recognize operating system or architecture, if your device not supported please consider make a PR"
fi
echo "Installing z script"
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/z.sh
source $HOME/.zshrc