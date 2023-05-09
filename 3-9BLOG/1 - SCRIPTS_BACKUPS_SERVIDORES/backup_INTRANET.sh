#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_OCS-GLPi.sh                            #
# Descrição      :   Backup do OCS e GLPi.                         #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_OCS-GLPi.sh                        #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 23/04/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inicio e Fim                       #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #
# Arquivo de recibo de backup
backup_dir=/home/administrador/backup

# Pasta contém arquivos intranet
intranet_dir=/var/www/html/intranet

# BDD intranet identificadores
intranet_server=localhost
intranet_user=root
intranet_password='S4nt@Bl0g*1973'
intranet_database=intranet

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-intranet-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup INTRANET iniciado em $HORAINICIAL.                                               |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

echo "Sistema de backup intranet" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

# Criação de uma pasta temporária e esvaziamento dela
echo "Criação da pasta temporária" >>"$LOG"
mkdir /tmp/backup-intranet &>/dev/null
rm -Rfv /tmp/backup-intranet/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-intranet/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-intranet" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-intranet" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados intranet
echo "Despejo de inventário intranet " >>"$LOG"
mysqldump -h$intranet_server -u$intranet_user -p$intranet_password $intranet_database >/tmp/backup-intranet/intranet_database_$current_date.sql

# Cópia de intranet no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório intranet" >>"$LOG"
rsync -az $intranet_dir /tmp/backup-intranet
echo "Alterando o nome do diretório intranet" >>"$LOG"
mv /tmp/backup-intranet/intranet /tmp/backup-intranet/intranet-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-intranet &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -az /tmp/backup-intranet $backup_dir

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-intranet &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-intranet-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-intranet/ &>/dev/null
scp -P 173 /mnt/server_backup/backup-intranet-$(date +%Y%m%d).tar.gz administrador@10.26.68.3:/mnt/Storage/Backups/INTRANET/

# Hora Final
HORAFINAL=$(date +%T)

echo "Backup Concluído em $HORAFINAL.                                                          |" >>"$LOG"
# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second),
TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
# $0 (variável de ambiente do nome do comando)
echo "---------------------------------------------------------------------------------------" >>"$LOG"
echo "|Tempo gasto para execução do script: $TEMPO.                                        |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

cp -rf $dir_log/$arq_log $destino
rm -Rfv /mnt/server_backup/*.tar.gz

exit 1

