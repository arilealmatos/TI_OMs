#!/bin/bash

zenity --question --title "Configurações" --text " Deseja desabilitar acesso a pendrive, hd externo e leitor de CD e DVD?" --width="300" height="50"

if [ "$?" -eq "0" ]
then
	
	chown hges /media
	chgrp adm /media
	chmod -R 770 /media
exit
fi

zenity --question --title "Configurações" --text " Deseja desabilitar acesso apenas a pendrive e hd externo?" --width="300" height="50"

if [ "$?" -eq "0" ]
then

	sed -i "s/#usb-storage/usb-storage/" /etc/modprobe.d/blacklist.conf
fi
