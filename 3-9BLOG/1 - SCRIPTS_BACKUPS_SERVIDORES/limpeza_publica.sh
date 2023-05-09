#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   limpeza_publica.sh                            #
# Descrição      :   Limpeza Diária da Pasta Publica.              #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   1º Sgt L. Matos                               #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./limpeza_publica.sh                        #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 23/04/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inico e Fim                        #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#Variaveis e Pastas
HORAINICIAL=$(date +%T)
current_date=`date +%d-%m-%Y_%H-%M`
publica=/home/samba/shares/Publica
pasta1=1_ESCMNT
pasta2=2_ESCMNT
pasta3=ADJUNTO_COMANDO
pasta4=ALMOX
pasta5=APROV
pasta6=BLINDADOS
pasta7=CCAP
pasta8=COAL
pasta9=COMANDANTE
pasta10=CONFORMIDADE
pasta11=DIGITALIZACOES
pasta12=DIV_PESSOAL
pasta13=DIV_SAUDE
pasta14=FISCADM
pasta15=GUARANI
pasta16=GRCP
pasta17=MNT
pasta18=NPOR
pasta19=PEL_APOIO
pasta20=PO
pasta21=PRM
pasta22=PROTOCOLISTA
pasta23=ROMANEIO
pasta24=RP
pasta25=S1
pasta26=S2
pasta27=S3
pasta28=S4
pasta29=SALC
pasta30=SET_FIN
pasta31=SPP
pasta32=SUP
pasta33=SUBCOMANDANTE
dir_log=/home/administrador/LOGs
arq_log="limpeza-publica-$current_date.txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "|Limpeza Pasta Publica iniciada em $HORAINICIAL.                                          |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

# Hora Final
HORAFINAL=$(date +%T)

#Apagar Arquivos e Pastas Publica Samba 4
rm -rf $publica/{$pasta1,$pasta2,$pasta3,$pasta4,$pasta5,$pasta6,$pasta7,$pasta8,$pasta9,$pasta10,$pasta11,$pasta12,$pasta13,$pasta14,$pasta15,$pasta16,$pasta17,$pasta18,$pasta19,$pasta20,$pasta21,$pasta22,$pasta23,$pasta24,$pasta25,$pasta26,$pasta27,$pasta28,$pasta29,$pasta30,$pasta31,$pasta32}
echo "---------------------------------------------------------------------------------------" >>"$LOG"
echo "Pastas Excluidas em $HORAFINAL!                                                            |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

#Recriar Pastas Publica
#cd $publica
mkdir -p $publica/{$pasta1,$pasta2,$pasta3,$pasta4,$pasta5,$pasta6,$pasta7,$pasta8,$pasta9,$pasta10,$pasta11,$pasta12,$pasta13,$pasta14,$pasta15,$pasta16,$pasta17,$pasta18,$pasta19,$pasta20,$pasta21,$pasta22,$pasta23,$pasta24,$pasta25,$pasta26,$pasta27,$pasta28,$pasta29,$pasta30,$pasta31,$pasta32}
echo "Pastas Recriadas em $HORAFINAL!">>"$LOG"

# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second),
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
# $0 (variável de ambiente do nome do comando)
echo "---------------------------------------------------------------------------------------" >>"$LOG"
echo "Tempo gasto para execução do script: $TEMPO.                                               |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

exit 1
