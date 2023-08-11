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

sudo apt update && sudo apt upgrade -y

sudo apt install -y gparted --install-recommends
sudo apt install -y software-properties-common --install-recommends
sudo apt install -y plymouth-themes* --install-recommends
sudo apt install -y dconf-editor --install-recommends
sudo apt install -y gimp --install-recommends
sudo apt install -y git --install-recommends
sudo apt install -y inkscape --install-recommends
sudo apt install -y meld --install-recommends
sudo apt install -y qbittorrent --install-recommends
sudo apt install -y simplescreenrecorder --install-recommends
sudo apt install -y sublime-text --install-recommends
sudo apt install -y telegram-desktop --install-recommends
sudo apt install -y vlc --install-recommends
sudo apt install -y yad --install-recommends
sudo apt install -y ntpdate --install-recommends
sudo apt install -y libmodule-install-perl dmidecode libxml-simple-perl libcompress-zlib-perl libnet-ip-perl libwww-perl libdigest-md5-perl libdata-uuid-perl --install-recommends
sudo apt install -y libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools libsys-syslog-perl pciutils smartmontools read-edid nmap libnet-netmask-perl --install-recommends
sudo apt install -y libfontconfig1 libfreetype6 libice6 libsm6 libx11-6 libx11-xcb1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render0 libxcb-render-util0 libxcb-shape0 libxcb-shm0 libxcb1 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 libxi6 libxml2 libxcb-xinerama0 gcc-multilib lib32atomic1 lib32gomp1 lib32itm1 lib32quadmath0 lib32stdc++6 libc6-dev-x32 libc6-x32 libx32atomic1 libx32gomp1 libx32itm1 libx32quadmath0 libx32stdc++6 libc6-dev-i386 libc6-i386 --install-recommends
sudo apt install -y build-essential libc6 libc6-dev wget --install-recommends
sudo apt install -y sddm --install-recommends
sudo apt install -y sddm-theme* --install-recommends

echo "################################################################"
echo "###################    Installation Done  ######################"
echo "################################################################"
