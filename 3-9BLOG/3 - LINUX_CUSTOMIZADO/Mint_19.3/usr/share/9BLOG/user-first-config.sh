#!/bin/bash

# ---------------------------------------------------------------- #
# Nome do Script :   user-first-config.sh                          #
# Descrição      :   Configuracao do Usuario.                      #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./user-first-config.sh                      #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

zenity --info --title="Atenção técnico!" --text="Script de configurações da interface de usuário LinuxMint 9BLOG 19.3 V_05-23" --width="300" height="50"

PASTA=$(zenity --title="Nome da pasta na rede" --text "Digite o nome do compartilhamento" --entry)

echo "[Desktop Entry]
Type=Application
Name=it1 em SERVIDOR-9BLOG
Icon=/usr/share/icons/Windows-10-1.0/48x48/places/folder-remote.png
Exec=nemo smb://10.26.68.2/it1" > $HOME/Área\ de\ Trabalho/$PASTA\ em\ SERVIDOR\ -\ 9BLOG.desktop
sed -i "s/it1/$PASTA/" $HOME/Área\ de\ Trabalho/$PASTA\ em\ SERVIDOR\ -\ 9BLOG.desktop
chown $USER $HOME/Área\ de\ Trabalho/$PASTA\ em\ SERVIDOR\ -\ 9BLOG.desktop
chmod +x $HOME/Área\ de\ Trabalho/$PASTA\ em\ SERVIDOR\ -\ 9BLOG.desktop

zenity --info --title="Atalho criado" --text="$PASTA - em SERVIDOR - 9BLOG" --width="300" height="50"

echo "[Desktop Entry]
Type=Application
Name=Publica em SERVIDOR-9BLOG
Icon=/usr/share/icons/Windows-10-1.0/48x48/places/folder-remote.png
Exec=nemo smb://10.26.68.2/Publica" > $HOME/Área\ de\ Trabalho/Pública\ em\ SERVIDOR\ -\ 9BLOG.desktop
chown $USER $HOME/Área\ de\ Trabalho/Pública\ em\ SERVIDOR\ -\ 9BLOG.desktop
chmod +x $HOME/Área\ de\ Trabalho/Pública\ em\ SERVIDOR\ -\ 9BLOG.desktop

echo "[Desktop Entry]
Type=Application
Name=SIMATEx OM
Icon=/usr/share/icons/Windows-10-1.0/simatex.png
Exec=wine $HOME/.wine/drive_c/SimatexOm/SimatexOm.exe" > $HOME/Área\ de\ Trabalho/SIMATExOM.desktop
chown $USER $HOME/Área\ de\ Trabalho/SIMATExOM.desktop
chmod +x $HOME/Área\ de\ Trabalho/SIMATExOM.desktop

#zenity --info --title="Atalho criado" --text="SIMATEx OM" --width="300" height="50";

#echo "[Desktop Entry]
#Type=Application
#Name=Boletins em SERVIDOR-9BLOG
#Icon=/usr/share/icons/Windows-10-1.0/48x48/places/folder-remote.png
#Exec=nemo smb://10.26.68.2/boletins" > $HOME/Área\ de\ Trabalho/Boletins\ em\ SERVIDOR\ -\ 9BLOG.desktop
#chown $USER $HOME/Área\ de\ Trabalho/Boletins\ em\ SERVIDOR\ -\ 9BLOG.desktop
#chmod +x $HOME/Área\ de\ Trabalho/Boletins\ em\ SERVIDOR\ -\ 9BLOG.desktop

#echo "[Desktop Entry]
#Type=Application
#Name=Modelos_Documentos em SERVIDOR-9BLOG
#Icon=/usr/share/icons/Windows-10-1.0/48x48/places/folder-remote.png
#Exec=nemo smb://10.26.68.2/modelos_documentos" > $HOME/Área\ de\ Trabalho/Modelos_Documentos\ em\ SERVIDOR\ -\ 9BLOG.desktop
#chown $USER $HOME/Área\ de\ Trabalho/Modelos_Documentos\ em\ SERVIDOR\ -\ 9BLOG.desktop
#chmod +x $HOME/Área\ de\ Trabalho/Modelos_Documentos\ em\ SERVIDOR\ -\ 9BLOG.desktop

#echo "[Desktop Entry]
#Type=Application
#Name=Publica em SAMBA-9BLOG
#Icon=/usr/share/icons/Windows-10-1.0/48x48/places/folder-remote.png
#Exec=nemo smb://10.79.28.27/publica" > $HOME/Área\ de\ Trabalho/Pública\ em\ SAMBA\ -\ 9BLOG.desktop
#chown $USER $HOME/Área\ de\ Trabalho/Pública\ em\ SAMBA\ -\ 9BLOG.desktop
#chmod +x $HOME/Área\ de\ Trabalho/Pública\ em\ SAMBA\ -\ 9BLOG.desktop

#zenity --info --title="Atalho para Pasta Pública criado! " --width="300" height="50"

zenity --question --title "Atalho FoxItReader(Windows)" --text "Precisa criar o atalho para FoxItReader(Windows)?" --width="300" height="50"

if [ "$?" -eq "0" ]
then

#     PASTA=$(zenity --title="Nome da pasta na rede" --text "Digite o nome do compartilhamento" --entry)

echo "[Desktop Entry]
Type=Application
Name=FoxItReader
Icon=/usr/share/icons/Windows-10-1.0/evince.png
Exec=wine $HOME/.wine/drive_c/Program\ Files\ (x86)/Foxit\ Software/Foxit\ PDF\ Reader/FoxitPDFReader.exe" > $HOME/Área\ de\ Trabalho/FoxItReader.desktop
chown $USER $HOME/Área\ de\ Trabalho/FoxItReader.desktop
chmod +x $HOME/Área\ de\ Trabalho/FoxItReader.desktop

zenity --info --title="Atalho criado" --text="FoxItReader(Windows)" --width="300" height="50";

fi

zenity --info --title="Configuração Concluída!" --text="Configuração concluída. Prossiga com as Opções de Administrador." --width="300" height="50"
