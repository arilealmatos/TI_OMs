#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Instala-ONLYOFFICE.sh                         #
# Descrição      :   Instal suite de escritorio ONLYOFFICE.        #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Instala-ONLYOFFICE.sh                     #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#INSTALAR ONLYOFFICE
#zenity --info --title="Instala ONLYOFFICE" --text="Atenção!" --width="300" height="50"

if [ "$?" -eq "1" ]
then
zenity --warning --width=400 --height=100 --text "Instala WPS"
exit
fi

if [ "$?" -eq "0" ]
then
 (
  echo 15
  echo "# Instalando o OnlyOffice..."
  dpkg -i onlyoffice.deb	

  echo 15
  echo "# Concluindo..."
  sleep 1	

  echo 25
  echo "# Concluindo..."
  sleep 1

  echo 35
  echo "# Concluindo..."
  sleep 1

  echo 45
  echo "# Concluindo..."
  sleep 1

  echo 55
  echo "# Concluindo..."     
  sleep 1

  echo 65
  echo "# Concluindo..."  
  sleep 1

  echo 75
  echo "# Pronto!"
) | zenity --title "Progresso" --progress --auto-kill --width="300" height="50"

fi

#dpkg -i wpsoffice.deb	
#echo -n "Seguir passo a passo. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'


zenity --info --title="OnlyOffice" --text="OnlyOffice Instalado. Prossiga com as Opções de Administrador, em seguida reinicie a máquina e faça o primeiro logon na conta do usuário" --width="300" height="50"
#./Opções\ do\ Administrador.sh
