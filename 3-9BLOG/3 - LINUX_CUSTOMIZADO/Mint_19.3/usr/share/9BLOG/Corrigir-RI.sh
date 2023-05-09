#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Corrigir-RI.sh                                #
# Descrição      :   Corrigir nome host OCSIventory.               #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Corrigir-RI.sh                            #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

zenity --info --title="Configurações do OCS" --text="Definindo opções para $HOSTNAME no OCS" --width="300" height="50"
	HOSTN=$(cat /etc/hostname)
	sed -i 's/realm=.*/realm='$HOSTN'/' /etc/ocsinventory/ocsinventory-agent.cfg
	RI=$(zenity --title="Registro Interno" --text "Digite a TAG do $HOSTNAME" --entry)
	sed -i 's/tag=.*/tag='$RI'/' /etc/ocsinventory/ocsinventory-agent.cfg
    sed -i '5 s/NA/'$RI'/' /var/lib/ocsinventory-agent/http:__10.26.68.30_ocsinventory/ocsinv.adm
	ocsinventory-agent
 
zenity --info --title="Configuração Concluida" --text="OCSInventory Configurado." --width="300" height="50"
#./Opções\ do\ Administrador.sh
