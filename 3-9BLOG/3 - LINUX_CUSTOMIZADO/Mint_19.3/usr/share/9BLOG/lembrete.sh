#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   lembrete.sh                                   #
# Descrição      :   Lembrete inicializacao.                       #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Cb Martins(HGeS) | 1º Sgt L. Matos            #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./lembrete.sh                               #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#Pequena janela usando a ferramenta zenity para advertir os usuários quanto aos cuidados com arquivos importantes.

#!/bin/sh

# You must place file "LEMBR" in same folder of this script.
FILE=/usr/share/9BLOG/LEMBR

zenity --text-info \
       --title="Lembre-se!" \
       --filename=$FILE \
     
esac

