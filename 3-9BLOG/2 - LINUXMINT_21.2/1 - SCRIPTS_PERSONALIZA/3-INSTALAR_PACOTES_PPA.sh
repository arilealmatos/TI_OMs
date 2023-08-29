#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "################################################################"
echo "LIBREOFFICE"
echo "################################################################"
echo
echo "Adding the repo"
sudo add-apt-repository -y ppa:libreoffice/ppa

echo "################################################################"
echo "FIREFOX-ESR"
echo "################################################################"
echo
echo "Adding the repo"
sudo add-apt-repository ppa:mozillateam/ppa

echo "################################################################"
echo "Google Chrome"
echo "################################################################"
echo
echo "Getting the key"
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "Adding the repo"
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

echo "################################################################"
echo "Brave"
echo "################################################################"
echo
echo "Getting the key"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "Adding the repo"
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list


echo "################################################################"
echo "Visual studio"
echo "################################################################"
echo
echo "Getting the key"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "Adding the repo"
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

echo "################################################################"
echo "CLOSED IN DIRECTORY(CID)"
echo "################################################################"
echo
echo "Adding the repo"
sudo add-apt-repository ppa:emoraes25/cid

echo "################################################################"
echo "PALEMOON"
echo "################################################################"
echo
echo "Getting the key"
curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null
echo "Adding the repo"
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/home:stevenpusser.list

echo "################################################################"
echo "JAVA ORACLE"
echo "################################################################"
echo
echo "Getting the key"
echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu focal main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
echo "Adding the repo"
sudo add-apt-repository ppa:linuxuprising/java

echo "################################################################"
echo "ASSINADOR SERPRO"
echo "################################################################"
echo
echo "Getting the key"
wget -qO- https://assinadorserpro.estaleiro.serpro.gov.br/repository/AssinadorSERPROpublic.asc | sudo tee /etc/apt/trusted.gpg.d/AssinadorSERPROpublic.asc
echo "Adding the repo"
sudo add-apt-repository 'deb https://assinadorserpro.estaleiro.serpro.gov.br/repository/ universal stable'

echo "################################################################"
echo "GRUB-CUSTOMIZER"
echo "################################################################"
echo
echo "Adding the repo"
sudo add-apt-repository ppa:danielrichter2007/grub-customizer

echo "################################################################"
echo "EBCHAT"
echo "################################################################"
echo
echo "Getting the key"
wget -O- https://web-msg.eb.mil.br/apt/ebchat.public | gpg --dearmor > ebchat-desktop-keyring.gpg
cat ebchat-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/ebchat-desktop-keyring.gpg > /dev/null
echo "Adding the repo"
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/ebchat-desktop-keyring.gpg] https://web-msg.eb.mil.br/apt stable main' | sudo tee -a /etc/apt/sources.list.d/ebchat.list

echo "################################################################"
echo "OCSINVENTORY-AGENT"
echo "################################################################"
echo
echo "Getting the key"
curl -fsSL http://deb.ocsinventory-ng.org/pubkey.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/ocs-archive-keyring.gpg
echo "Adding the repo"
echo "deb http://deb.ocsinventory-ng.org/ubuntu/ jammy main" | sudo tee /etc/apt/sources.list.d/ocsinventory.list

echo "################################################################"
echo "WINE STABLE"
echo "################################################################"
echo
echo "Getting the key"
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
echo "Adding the repo"
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

echo "################################################################"
echo "TEMAS E CURSORES"
echo "################################################################"
echo
echo "Abrindo pasta e instalando"
cd files
cd We10XOS-cursors-master/
./install.sh 
cd ..
cd Win11-icon-theme-main/
./install.sh 
cd ..

echo "################################################################"
echo "NOMACHINE e TOKEN ADMIN"
echo "################################################################"
echo
echo "Abrindo pasta e instalando"
cd files
dpkg -i nomachine_8.8.1_1_amd64.deb
dpkg -i SafeSign.deb
cd ..

sudo apt update && sudo apt upgrade -y

#Installed via keys and repo add
sudo apt install -y libreoffice libreoffice-l10n-pt-br libreoffice-style-breeze --install-recommends
sudo apt install -y firefox-esr --install-recommends
sudo apt install -y google-chrome-stable --install-recommends
sudo apt install -y brave-browser --install-recommends
sudo apt install -y code --install-recommends
sudo apt install -y cid cid-gtk --install-recommends
sudo apt install -y palemoon --install-recommends
sudo apt install -y oracle-java17-installer --install-recommends
sudo apt install -y assinador-serpro --install-recommends
sudo apt install -y grub-customizer --install-recommends
sudo apt install -y ebchat-desktop --install-recommends
sudo apt install -y ocsinventory-agent --install-recommends
sudo apt install -y winehq-stable --install-recommends
echo "Adicionando GECKO e MONO"
sudo mkdir /opt/wine-stable/share/wine/mono
sudo wget -O - https://dl.winehq.org/wine/wine-mono/8.0.0/wine-mono-8.0.0-dbgsym.tar.xz | sudo tar -xJv -C /opt/wine-stable/share/wine/mono
sudo mkdir /opt/wine-stable/share/wine/gecko
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.3-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.3/wine-gecko-2.47.3-x86.msi
sudo wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.3-x86_64.msi https://dl.winehq.org/wine/wine-gecko/2.47.3/wine-gecko-2.47.3-x86_64.msi
sudo apt install -y build-essential gcc-multilib gcc-mingw-w64 libasound2-dev libpulse-dev libdbus-1-dev libfontconfig-dev libfreetype-dev libgnutls28-dev libgl-dev libunwind-dev libx11-dev libxcomposite-dev libxcursor-dev libxfixes-dev libxi-dev libxrandr-dev libxrender-dev libxext-dev bison flex --install-recommends

echo "################################################################"
echo "###################    Installation Done  ######################"
echo "################################################################"
