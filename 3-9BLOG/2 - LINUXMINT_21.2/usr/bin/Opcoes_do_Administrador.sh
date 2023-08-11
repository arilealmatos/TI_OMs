#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   Opcoes_do_Administrador.sh                    #
# Descrição      :   Opcoes do Administrador.                      #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./Opcoes_do_Administrador.sh                #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
zenity --error --text="Precisa ser root!"
exit
fi

show_list() {

ESCOLHIDO=$( \
   yad --list \
   --image=/usr/share/9BLOG/0.png --list --window-icon=/usr/share/9BLOG/com.png \
   --title="Opções do Administrador" \
   --column="Marque":NUM \
   --column="Opção":TEXT \
   --print-column=1 \
   --hide-column=1 \
      --width="500" \
      --height="400" \
      --button="Sair":1 \
   1 "Atualizar" \
   2 "Criar Usuario" \
   3 "Ingressar no Dominio 9BLOG" \
   4 "Desativar Mídias de Armazenamento" \
   5 "Ativar Mídias de Armazenamento" \
   6 "Corrigir TAG OCS" \
   7 "Atualizar TAG OCS" \
   8 "Instalar Kaspersky 11.4" \
   9 "Instalar Agente Kaspersky 11.4" \
)

# ver se o usuário clicou em 'sair' or no 'x' da janela
ACAO="$?"
test "$ACAO" -eq "1" || test "$ACAO" -eq "252"
if [ "$?" -eq "0" ]; then
   exit
fi

#captura apenas o numero da opcao selecionada
ESCOLHIDO=$(echo $ESCOLHIDO | egrep -o '^[0-9]')

cd /usr/share/9BLOG/
# de acordo com a opcao selecionada, instale o script
case "$ESCOLHIDO" in
   1)
      ./Atualizar.sh
      show_list
   ;;
   2)
      ./Criar-Usuario.sh
      show_list
   ;;
   3)
      ./Ingressar-no-dominio.sh
      show_list
   ;;
   4)
      ./Desativar-midias-de-armazenamento.sh
      show_list
   ;;
   5)
      ./Ativar-midias-de-armazenamento.sh
      show_list
   ;;
   6)
      ./Corrigir-RI.sh
      show_list
   ;;
   7)
      ./Atualizar-RI.sh
      show_list
   ;;
   8)
      sudo xterm -e "./install.sh; exec $SHELL";
      show_list
   ;;
   9)
     ./install_klnagent.sh
     show_list
   ;;
   *)
      yad --image="face-angry.png" \
         --title="Alerta" \
         --text "Você não selecionou uma opção válida!" \
         --button="Voltar e Selecionar"
      show_list
   ;;
esac
}
show_list

#.EOF
