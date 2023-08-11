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
echo "SYSTEMBACK 1.9.4"
echo "################################################################"
echo
echo "Preparando"
sudo apt install -y unionfs-fuse --install-recommends
sudo apt install -y live-boot --install-recommends
sudo apt remove -y casper
sudo apt install -y grub2-common grub-efi-amd64-bin grub-pc-bin --install-recommends
sudo apt install -y xorriso xfonts-cyrillic --install-recommends

#Instalar .deb
cd files
cd systemback-1.9.4hamonikr9/
dpkg -i *.deb
sudo apt-get -f install
update-initramfs -u
cd ..
sudo apt install -y ubiquity ubiquity-frontend-gtk --install-recommends

echo "################################################################"
echo "###################    Installation Done  ######################"
echo "################################################################"
