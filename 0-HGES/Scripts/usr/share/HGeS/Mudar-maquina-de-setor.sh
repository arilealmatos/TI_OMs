#!/bin/bash

#Script desenvolvido para agilizar o processo de migração e atualização dos computadores com sistemas GNU\Linux no setor de Informática do HGeS.  >>> VERSÃO 11.0 <<<

zenity --info --title="Configuração da máquina" --text="Alterando Hostname e opções do OCS" --width="300" height="50"
HOSTN=$(zenity --title="Novo Hostname" --text "Digite o NOVO HOSTNAME da máquina" --entry)
	echo "$HOSTN" > /etc/hostname
	sed -i "s/realm=.*/realm=$HOSTN/" /etc/ocsinventory/ocsinventory-agent.cfg
