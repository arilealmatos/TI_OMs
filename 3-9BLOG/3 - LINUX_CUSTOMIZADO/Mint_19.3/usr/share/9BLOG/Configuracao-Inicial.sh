#!/bin/bash

# ---------------------------------------------------------------- #
# Nome do Script :   Configuracao-Inicial.sh                       #
# Descrição      :   Inicio de configurações.                      #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Configuracao-Inicial.sh                   #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# -----------------------------------------------------------------#
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# -----------------------------------------------------------------#


#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
zenity --error --text="Precisa ser root!"
exit
fi

#Apresentação
zenity --info --title="Atenção!" --text="Script de configurações pós instalação do LinuxMint 19.3 9BLOG V_05-23" --width="300" height="50"

if [ "$?" -eq "1" ]
then
zenity --warning --width=400 --height=100 --text "Por favor, aguarde atualizações do APT!"
exit
fi

if [ "$?" -eq "0" ]
then
 (
  echo 15
  echo "# Atualizando cache do apt..."
  apt update -y	

  echo 25
  echo "# Atualizando cache do apt..."
  clear

  echo 35
  echo "# Removendo configurações residuais..."
  apt autoremove -y

  echo 45
  echo "# Instalando atualizações..."
  apt upgrade -y
  sleep 1

  echo 55
  echo "# Concluindo..."     
  apt autoclean -y

  echo 65
  echo "# Concluindo..."  
  sleep 1

  echo 75
  echo "# Pronto!"
) | zenity --title "Progresso" --progress --auto-kill --width="300" height="50"

fi

#CONFIGURAÇÕES DO AGENTE OCS INVENTORY
zenity --info --title="Configurações do OCS" --text="Definindo opções para $HOSTNAME no OCS" --width="300" height="50"
	sed -i "s/&/realm=$HOSTNAME/" /etc/ocsinventory/ocsinventory-agent.cfg
RI=$(zenity --title="Registro Interno" --text "Digite o RI da $HOSTNAME" --entry)
	sed -i "6s/.*/tag=$RI/" /etc/ocsinventory/ocsinventory-agent.cfg
zenity --info --title="Configurações do OCS" --text="Agente do OCS configurado. Caso seja necessária alguma alteração, use o script de Opções do Administrador" --width="300" height="50"

#INGRESSAR NO DOMÍNIO 3CIAFESP
#zenity --info --title="Ingressar no Domínio PQRMNT12" --text="Confira as definições do arquivo /etc/resolv.conf" --width="300" height="50"

	
#xterm -e bash -c '/usr/sbin/cid-gtk;echo;echo -n "Se houve alguma falha no ingresso ao AD cheque novamente a interface de rede, reinicie o o computador e use o script de Opcoes do Administrador. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'

zenity --info --title="Configuração inicial" --text="Configuração inicial concluída. Prossiga com as Opções de Administrador, em seguida reinicie a máquina e faça o primeiro logon na conta do usuário" --width="300" height="50"

#AUTOEXCLUSÃO
#rm -f /home/$USER/Instala/Configuração\ inicial.desktop
