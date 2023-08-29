#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_SIGAPS.sh                              #
# Descrição      :   Backup do SIGAPS.                             #
# Site           :   http://sigaps.9blog.eb.mil.br                 #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_sigaps.sh                          #
# ---------------------------------------------------------------- #
# Histórico      :   v1.0 28/08/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inicio e Fim                       #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #
# Arquivo de recibo de backup
backup_dir=/home/sti/backup

# Pasta contém arquivos sigaps
sigaps_dir=/var/www/

# BDD sigaps identificadores
sigaps_server=localhost
sigaps_user=sti
sigaps_password='0x1uru5'
sigaps_database=sigaps

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/sti/LOGs
arq_log="backup-sigaps-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup SIGAPS iniciado em $HORAINICIAL.                                               |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

echo "Sistema de backup sigaps" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

# Criação de uma pasta temporária e esvaziamento dela
echo "Criação da pasta temporária" >>"$LOG"
mkdir /tmp/backup-sigaps &>/dev/null
rm -Rfv /tmp/backup-sigaps/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-sigaps/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-sigaps" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-sigaps" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados sigaps
echo "Despejo de inventário sigaps " >>"$LOG"
mysqldump -h$sigaps_server -u$sigaps_user -p$sigaps_password $sigaps_database >/tmp/backup-sigaps/sigaps_database_$current_date.sql

# Cópia de sigaps no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório sigaps" >>"$LOG"
rsync -az $sigaps_dir /tmp/backup-sigaps
echo "Alterando o nome do diretório sigaps" >>"$LOG"
mv /tmp/backup-sigaps/sigaps /tmp/backup-sigaps/sigaps-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-sigaps &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -az /tmp/backup-sigaps $backup_dir

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-sigaps &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-sigaps-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-sigaps/ &>/dev/null
scp -P 173 /mnt/server_backup/backup-sigaps-$(date +%Y%m%d).tar.gz administrador@10.26.68.6:/mnt/Storage/Backups/sigaps/

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

