#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Atualizar-RI.sh                               #
# Descrição      :   Atualizar TAG OCSIventory.                    #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Atualizar-RI.sh                           #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 17/04/2023, 1º Sgt L. Matos:             #
#                     - Renomear                                   #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

zenity --info --title="Configurações do OCS" --text="Definindo opções para $HOSTNAME no OCS" --width="300" height="50"
	HOSTN=$(cat /etc/hostname)
	sed -i 's/realm=.*/realm='$HOSTN'/' /etc/ocsinventory/ocsinventory-agent.cfg
    RI=$(zenity --title="Registro Interno" --text "Atualize a TAG do $HOSTNAME" --entry)
	sed -i 's/tag=.*/tag='$RI'/' /etc/ocsinventory/ocsinventory-agent.cfg
	sed -i '5 s/>[^>]*</>'$RI'</g' /var/lib/ocsinventory-agent/http:__10.26.68.30_ocsinventory/ocsinv.adm
	unset http_proxy
	ocsinventory-agent
  
zenity --info --title="Configuração Concluida" --text="OCSInventory Atualizado." --width="300" height="50"
#./Opções\ do\ Administrador.sh
