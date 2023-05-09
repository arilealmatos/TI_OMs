#!/bin/bash

# ---------------------------------------------------------------- #
# Nome do Script :   Grupo-Usuario.sh                              #
# Descrição      :   Script para adicionar usuário a Grupo.        #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Josivan Barbosa IFPB(ivan_jp01@hotmail.com)   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Grupo-Usuario.sh                          #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
gksu $0
exit
fi

Menu () {
opcao=$(zenity --list --column "Gerência de usuários." \
--title="Gerência de usuários." \
"Adicionar Grupos ao Usuário." )

case ${opcao} in
"Adicionar Grupos ao Usuário.")Adicionar ;;
esac
}

Adicionar () {
usuario=`zenity --entry \
--title="Adicionar Grupos ao Usuário" \
--text="Digite o nome do Usuário:"`
if [ $? -eq 1 ] ; then # Volta ao menu principal se o usuário clicar em "Cancelar"
Menu

elif [ -z $usuario ] ; then # Verifica se foi digitado um nome para o usuário.
zenity --error --text="Informe um nome para o Usuário!"
Adicionar

#elif ! [ -z `grep -w $usuario /etc/passwd` ] ; then # Verifica se o usuário ja existe.
#zenity --error --text="Usuário já existe!"
#Adicionar

else
while true ; do # Após adiciona Grupos
#senha=`zenity --entry \
#--title="Adcionar Usuário." \
#--text="Digite a senha:" \
#--hide-text`
#if [ $? -eq 1 ] ; then # Volta ao menu principal se o usuário clicar em "cancelar".
#break

#elif [ -z $senha ] ; then # Verifica se foi digitado uma senha.
#zenity --error --text="Informe uma senha!"

#else
#useradd -m $usuario # Adciona o novo usuário
#echo $usuario:$senha | chpasswd
usermod -a -G dip,lp,lpadmin,plugdev,sambashare $usuario
zenity --info --text="Grupos do Usuário '$usuario' adicionados com sucesso!"
break

#fi
done

fi
}

Menu
#./Opções\ do\ Administrador.sh
