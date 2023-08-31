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
backup_dir=/home/sti/backups

# Pasta contém arquivos SIGAPS
sigapsrec_dir=/var/www

# BDD SIGAPS identifiers
sigaps_server=localhost
sigaps_user=root
sigaps_password='força3'
sigaps_database=sigaps

# Identificadores BDD SIGAPSREC
sigapsrec_server=localhost
sigapsrec_user=root
sigapsrec_password='força3'
sigapsrec_database=sigaps_visitantes

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/sti/LOGs
arq_log="backup-sigaps-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup SIGAPS e SIGAPSREC iniciado em $HORAINICIAL.                                          |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

# Verifique uma montagem
#mount_verify=yes
#mount_dir=/home/sti/backup
echo "Sistema de backup do SIGAPS e SIGAPSREC" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "-------------------------------------------------------------------------------------------" >>"$LOG"
# Verificação de uma montagem
# Esta parte do script é usada para verificar uma montagem antes de executar o backup.
# Por exemplo, para uma transferência para um servidor de compartilhamento 'cifs' do Windows, você deve verificar se o compartilhamento está montado corretamente.
#if [[ "$mount_verify" = "yes" ]]
#then
#        check_mount=`mount | grep $mount_dir | wc -l`;
#        if [[ "$check_mount" -eq "0" ]]
#        then
#                echo "ERRO: A pasta $ mount_dir não parece estar montada"
#                exit 1
#        fi
#fi

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

# MySQLDUMP do banco de dados SIGAPS
echo "Despejo de inventário SIGAPS" >>"$LOG"
mysqldump -h$sigaps_server -u$sigaps_user -p$sigaps_password $sigaps_database >/tmp/backup-sigaps/sigaps_database_$current_date.sql

# MySQLDUMP do banco de dados SIGAPSREC
echo "Despejo da base GLPI" >>"$LOG"
mysqldump -h$sigapsrec_server -u$sigapsrec_user -p$sigapsrec_password $sigapsrec_database >/tmp/backup-sigaps/sigapsrec_database_$current_date.sql

# Cópia de SIGAPS no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório GLPI" >>"$LOG"
rsync -az $sigapsrec_dir /tmp/backup-sigaps
echo "Alterando o nome do diretório SIGAPS" >>"$LOG"
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

echo "|Backup Concluído em $HORAFINAL.                                                          |" >>"$LOG"
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

cp -rf $dir_log/$arq_log $destino/$current_date
rm -Rfv /mnt/server_backup/*.tar.gz

exit 1

