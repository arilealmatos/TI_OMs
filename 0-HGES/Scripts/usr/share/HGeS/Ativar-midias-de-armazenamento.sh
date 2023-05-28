#!/bin/bash

zenity --question --title "Configurações" --text " Habilitar acesso a pendrive, hd externo e leitor de CD e DVD" --width="300" height="50"

if [ "$?" -eq "0" ]
then
	
	chmod -R 777 /media
exit
fi

zenity --question --title "Configurações" --text " Habilitar acesso a pendrive e hd externo" --width="300" height="50"

if [ "$?" -eq "0" ]
then

	sed -i "s/usb-storage/#usb-storage/" /etc/modprobe.d/blacklist.conf
fi
