#!/bin/bash

#Script desenvolvido para agilizar o processo de migração e atualização dos computadores com sistemas GNU\Linux no setor de Informática do HGeS.  >>> VERSÃO 11.0 <<<

#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
zenity --error --text="Precisa ser root!"
exit
fi

#Apresentação
zenity --info --title="Atenção!" --text="Script de configurações pós instalação do Ubuntu HGeS 18.04" --width="300" height="50"

#REMOVER O SYSTEMBACK (USADO PARA SALVAR A ISO) E OUTRAS INFORMAÇÕES DESNECESSÁRIAS
zenity --question --title "Confirmação" --text "Você já configurou a interface de rede, atribuindo corretamente o IP à máquina?" --no-wrap --width="300" height="50"

if [ "$?" -eq "1" ]
then
zenity --warning --width=400 --height=100 --text "Por favor, configure o IP da máquina e certifique-se de estar conectado à rede local"
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
  apt remove systemback -y

  echo 40
  echo "# Removendo configurações residuais..."
  apt autoremove -y

  echo 50
  echo "# Removendo configurações residuais..."
  apt remove usb-creator-gtk -y

  echo 70
  echo "# Removendo configurações residuais..."
  rm -R /home/Systemback

  echo 80
  echo "# Instalando atualizações..."
  apt upgrade -y
  sleep 1

  echo 85
  echo "# Concluindo..."     
  apt autoclean -y

  echo 90
  echo "# Concluindo..."  
  sleep 1

  echo 100
  echo "# Pronto!"
) | zenity --title "Progresso" --progress --auto-kill --width="300" height="50"

fi

#CONFIGURAÇÕES DO AGENTE OCS INVENTORY
zenity --info --title="Configurações do OCS" --text="Definindo opções para $HOSTNAME no OCS" --width="300" height="50"
	sed -i "s/&/realm=$HOSTNAME/" /etc/ocsinventory/ocsinventory-agent.cfg
RI=$(zenity --title="Registro Interno" --text "Digite o RI da $HOSTNAME" --entry)
	sed -i "6s/.*/tag=$RI/" /etc/ocsinventory/ocsinventory-agent.cfg
zenity --info --title="Configurações do OCS" --text="Agente do OCS configurado. Caso seja necessária alguma alteração, use o script de Opções do Administrador" --width="300" height="50"

#INGRESSAR NO DOMÍNIO HGES
zenity --info --title="Ingressar no Domínio HGeS" --text="Confira as definições de IP e conexão com a rede local, use apenas o DNS 10.111.90.10" --width="300" height="50"

	
xterm -e bash -c 'domainjoin-cli join hges.eb Administrador senhaderede;echo;echo -n "Se houve alguma falha no ingresso ao AD cheque novamente a interface de rede, reinicie o o computador e use o script de Opcoes do Administrador. Pressione ENTER para sair"; stty sane -echo;answer=$( while ! head -c 1;do true ;done);'

zenity --info --title="Configuração inicial" --text="Configuração inicial concluída. Prossiga com as Opções de Administrador, em seguida reinicie a máquina e faça o primeiro logon na conta do usuário" --width="300" height="50"

#AUTOEXCLUSÃO
rm -f /home/hges/Área\ de\ Trabalho/Configuração\ inicial.desktop
