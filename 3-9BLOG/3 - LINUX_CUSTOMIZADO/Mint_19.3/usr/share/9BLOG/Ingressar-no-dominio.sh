#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Ingressar-no-dominio.sh                       #
# Descrição      :   Entrar no dominio Zentyal.                    #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Ingressar-no-dominio.sh                   #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#INGRESSAR NO DOMÍNIO 9BLOG
zenity --info --title="Ingressar no Domínio 9BLOG" --text="Confira as definições do arquivo /etc/resolv.conf" --width="300" height="50"
ntpdate -u 10.26.68.2

	
xterm -e bash -c '/usr/sbin/cid-gtk;echo;echo -n "Se houve alguma falha no ingresso ao AD cheque novamente a interface de rede, reinicie o o computador e use o script de Opcoes do Administrador. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'
