#!/bin/bash

#INGRESSAR NO DOMÍNIO HGES
zenity --info --title="Ingressar no Domínio HGeS" --text="Confira as definições de IP e conexão com a rede local, use apenas o DNS 10.111.90.10" --width="300" height="50"

	
xterm -e bash -c 'domainjoin-cli join hges.eb Administrador senhaderede;echo;echo -n "Se houve alguma falha no ingresso ao AD cheque novamente a interface de rede, reinicie o o computador e use o script de Opcoes do Administrador. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'
