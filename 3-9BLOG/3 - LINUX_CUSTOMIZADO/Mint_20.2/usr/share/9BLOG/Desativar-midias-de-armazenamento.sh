#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Desativar-midias-de-armazenamento.sh          #
# Descrição      :   Retirar acesso a midias de armazenamento USB. #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Desativar-midias-de-armazenamento.sh      #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

zenity --question --title "Configurações" --text " Deseja desabilitar acesso a pendrive, hd externo e leitor de CD e DVD?" --width="300" height="50"

if [ "$?" -eq "0" ]
then
	
	chown administrador /media
	chgrp adm /media
	chmod -R 700 /media
exit
fi

zenity --question --title "Configurações" --text " Deseja desabilitar acesso apenas a pendrive e hd externo?" --width="300" height="50"

if [ "$?" -eq "0" ]
then

	sed -i "s/#usb-storage/usb-storage/" /etc/modprobe.d/blacklist.conf
fi

zenity --info --title="Desativação Concluida" --text="Desativação de PenDrive concluída." --width="300" height="50"
#./Opções\ do\ Administrador.sh
