#!/bin/bash

# ---------------------------------------------------------------- #
# Nome do Script :   Criar-Usuario.sh                              #
# Descrição      :   Script para adicionar e remover usuários.     #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Josivan Barbosa IFPB(ivan_jp01@hotmail.com)   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Criar-Usuario.sh                          #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #
ntpdate -u 10.26.68.2

#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
gksu $0
exit
fi

Menu () {
opcao=$(zenity --list --column "Gerência de usuários." \
--title="Gerência de usuários." \
"Adicionar Usuário." \
"Remover Usuário." )

case ${opcao} in
"Adicionar Usuário.")Adicionar ;;
"Remover Usuário.")Remover ;;
esac
}

Adicionar () {
usuario=`zenity --entry \
--title="Adicionar Usuário" \
--text="Digite o nome do Usuário:"`
if [ $? -eq 1 ] ; then # Volta ao menu principal se o usuário clicar em "Cancelar"
Menu

elif [ -z $usuario ] ; then # Verifica se foi digitado um nome para o usuário.
zenity --error --text="Informe um nome para o Usuário!"
Adicionar

elif ! [ -z `grep -w $usuario /etc/passwd` ] ; then # Verifica se o usuário ja existe.
zenity --error --text="Usuário já existe!"
Adicionar

else
while true ; do # Campo para cadastro da senha
senha=`zenity --entry \
--title="Adcionar Usuário." \
--text="Digite a senha:" \
--hide-text`
if [ $? -eq 1 ] ; then # Volta ao menu principal se o usuário clicar em "cancelar".
break

elif [ -z $senha ] ; then # Verifica se foi digitado uma senha.
zenity --error --text="Informe uma senha!"

else
useradd -m $usuario # Adciona o novo usuário
echo $usuario:$senha | chpasswd
usermod -a -G dip,lp,lpadmin,plugdev,sambashare $usuario
zenity --info --text="Usuário '$usuario' adcionado com sucesso!"
break

fi
done

Menu

fi
}

Remover () {
usuario=`zenity --entry \
--title="Remover Usuário." \
--text="Digite o nome do usuário:"`

if [ $? -eq 1 ] ; then # Volta ao menu principal se o usuário clicar em "cancelar".
Menu

elif [ -z $usuario ] ; then # Verifica se foi informado um usuário.
zenity --error --text="Informe o nome do usuário!"
Remover

elif [ -z `grep -w $usuario /etc/passwd` ] ; then # Verifica se o usuário existe.
zenity --error --text="Usuário não existe!"
Remover

elif zenity --question \
--text="Deseja remover o diretório home do Usuário '$usuario'"?""
then
userdel -r $usuario # Remove o usuário e seu diretório home.
zenity --info --text="Usuário '$usuario' removido com sucesso!"
Menu

else
userdel $usuario # Remove o usuário e mantém seu diretório home.
zenity --info --text="Usuário '$usuario' removido com sucesso!"
Menu

fi
}
Menu
#./Opções\ do\ Administrador.sh
