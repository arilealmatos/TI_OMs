#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Ativar-midias-de-armazenamento.sh             #
# Descrição      :   Reativar midias de armazenamento.             #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Ativar-midias-de-armazenamento.sh         #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#zenity --question --title "Configurações" --text " Habilitar acesso a pendrive, HD externo e leitor de CD e DVD" --width="300" height="50"

if [ "$?" -eq "0" ]
then
	
	chmod -R 777 /media
exit
fi

zenity --question --title "Configurações" --text " Habilitar acesso a Pendrive e HD externo" --width="300" height="50"

if [ "$?" -eq "0" ]
then

	sed -i "s/usb-storage/#usb-storage/" /etc/modprobe.d/blacklist.conf
fi

zenity --info --title="Ativação Concluida" --text="Ativação de PenDrive concluída." --width="300" height="50"
#./Opções\ do\ Administrador.sh
