#!/bin/bash

#Script desenvolvido para agilizar o processo de migração e atualização dos computadores com sistemas GNU\Linux no setor de Informática do HGeS.  >>> VERSÃO 11.0 <<<

zenity --info --title="Atenção técnico!" --text="Script de configurações da interface de usuário Ubuntu HGeS 18.04" --width="300" height="50"

PASTA=$(zenity --title="Nome da pasta na rede" --text "Digite o nome do compartilhamento" --entry)

echo "[Desktop Entry]
Type=Application
Name=it1 em hges-servidor
Icon=/usr/share/icons/Windows10/32x32/places/folder-remote.png
Exec=nemo smb://hges-servidor/it1" > $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
sed -i "s/it1/$PASTA/" $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
chown $USER $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
chmod +x $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop

zenity --info --title="Atalho criado" --text="$PASTA - em HGeS - Servidor" --width="300" height="50"

zenity --question --title "Novo atalho" --text "Precisa de outro atalho para uma pasta no servidor?" --width="300" height="50"

if [ "$?" -eq "0" ]
then

        PASTA=$(zenity --title="Nome da pasta na rede" --text "Digite o nome do compartilhamento" --entry)

echo "[Desktop Entry]
Type=Application
Name=it1 em hges-servidor
Icon=/usr/share/icons/Windows10/32x32/places/folder-remote.png
Exec=nemo smb://hges-servidor/it1" > $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
sed -i "s/it1/$PASTA/" $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
chown $USER $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop
chmod +x $HOME/Área\ de\ Trabalho/$PASTA\ em\ HGeS\ -\ Servidor.desktop

zenity --info --title="Atalho criado" --text="$PASTA - em HGeS - Servidor, se precisar de outro se vire!" --width="300" height="50";

fi

rm -f $HOME/.config/autostart/user-first-config.desktop
