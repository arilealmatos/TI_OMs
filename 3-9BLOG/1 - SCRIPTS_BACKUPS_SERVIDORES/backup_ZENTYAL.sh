#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   servidor_backup.sh                            #
# Descrição      :   Backup de Servidor SAMBA Zentyal.             #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   1º Sgt L. Matos                               #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./servidor_backup.sh                        #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 23/04/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inicio e Fim                       #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

#Variaveis e Pastas
current_date=`date +%d-%m-%Y_%H-%M`
samba=/home/samba/shares/
dir_log=/home/administrador/LOGs
arq_log="backup-samba-$current_date.txt"
destino=/mnt/backup/

# Hora Inicial
HORAINICIAL=$(date +%T)

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "|Backup Pastas SERVIDOR-9BLOG iniciado em $HORAINICIAL.                                   |">>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

#Copiar Arquivos e Pastas Samba 4
rm -rf $destino/*
echo 'Gu4r4n12022' | sshfs -p 173 -o password_stdin,nonempty administrador@10.26.68.3:/mnt/Storage/Backups/Servidor/ $destino
cd $destino
mkdir -p $current_date
cp -rf $samba/* $destino/$current_date

# Hora Final
HORAFINAL=$(date +%T)

echo "---------------------------------------------------------------------------------------" >>"$LOG"
echo "|  Pastas Copiadas em $HORAFINAL.                                                          |" >>"$LOG"
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

cp -rf $dir_log/$arq_log $destino/$current_date
sleep 30
umount -f $destino

exit 1
