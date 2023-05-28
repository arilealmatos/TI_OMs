#!/bin/bash

#ABANDONAR DOMÍNIO HGES
zenity --info --title="Sair do Domínio HGeS" --text="Você está desconectando a máquina do Servidor AD" --width="300" height="50"

	
xterm -e bash -c 'domainjoin-cli leave;echo;echo -n "Reinicie o o computador e use o script de Opcoes do Administrador para reingressar no dominio. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'
