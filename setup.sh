/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo easy_install pip

brew install git
brew install fzf
brew install wget
brew install nmap
brew install cask

brew cask install google-chrome
brew cask install firefox
brew cask install docker
brew cask install visual-studio-code
brew cask install iterm2
brew cask install todoist


mkdir -p ~/src/tools
mkdir ~/src/work
mkdir ~/src/personal

git clone https://github.com/mrz1988/lilies.git ~/src/tools
python ~/src/tools/lilies/setup.py install
git clone https://github.com/mrz1988/ls.git ~/src/tools

git clone https://github.com/mrz1988/sh-utils.git ~/src/tools
cp ~/src/tools/sh-utils/bash_profile.txt ~/.bash_profile

echo Done!
echo Please reboot your terminal window.
