!/bin/bash

# ---------------------------------------------------------------- #
# Nome do Script :   install.sh                                    #
# Descrição      :   Modulo de Protecao Cibernetica.               #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./install.sh                                #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

clear;
echo "";

BACKTITLE='Protecao Cibernetica 9 B Log'
INTRO='
Bem-Vindo(a) ao Módulo de Proteção Cibernetica!

Este script instala o agente e o antivirus Kaspersky.

DICAS:
- Pressione backspace para confirmar a leitura.
- Para desinstalar use o Gerenciador de Aplicativos.

'

#.....................................................................

dialog --backtitle "$BACKTITLE" \
   --cr-wrap \
   --title 'STI' \
   --msgbox "$INTRO" \
   17 55 &&

#.....................................................................

# Capturando as escolhas do usuario.
# Note a presenca do --stdout e do subshell $(comando) 
while : ; do

ESCOLHA=$(dialog --stdout --menu 'Escolha Sua Opcao' \
       0 0 0 1 'Instalar Kaspersky' \
             2 'Sair')
dialog --infobox "A Opcao Escolhida foi:\n $ESCOLHA" 4 30
read

# Escolheu CANCELAR ou ESC, então vamos sair...
[ $? -ne 2 ] && break

# De acordo com a opção escolhida, dispara programas
    case "$ESCOLHA" in
         1) /usr/share/9BLOG/install.sh ;;
         2) break ;;
    esac


done

# Mensagem final :)
clear
echo 'Obrigado por utilizar nosso sistema. Digite clear para limpar a tela!' 