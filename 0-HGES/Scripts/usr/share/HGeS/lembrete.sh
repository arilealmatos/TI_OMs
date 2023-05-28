#!/bin/bash

#Pequena janela usando a ferramenta zenity para advertir os usuários quanto aos cuidados com arquivos importantes.

#!/bin/sh

# You must place file "LEMBR" in same folder of this script.
FILE=/usr/share/HGeS/LEMBR

zenity --text-info \
       --title="Lembre-se!" \
       --filename=$FILE \
     
esac

