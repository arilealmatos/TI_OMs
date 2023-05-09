#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Sair-do-dominio.sh                            #
# Descrição      :   Deixar dominio Zentyal.                       #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Sair-do-dominio.sh                        #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#ABANDONAR DOMÍNIO 9BLOG
zenity --info --title="Sair do Domínio 9BLOG" --text="Você está desconectando a máquina do Servidor AD" --width="300" height="50"

	
xterm -e bash -c '/usr/sbin/cid-gtk;echo;echo -n "Reinicie o o computador e use o script de Opcoes do Administrador para reingressar no dominio. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'
