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
#                     - Hora de Inico e Fim                        #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

# Arquivo de recibo de backup
backup_dir=/home/administrador/backup

# Pasta contém arquivos GLPI
glpi_dir=/var/www/html/glpi

# BDD OCS Inventory NG identifiers
ocs_server=localhost
ocs_user=root
ocs_password='SUA_SENHA'
ocs_database=ocsweb

# Identificadores BDD GLPI
glpi_server=localhost
glpi_user=root
glpi_password='SUA_SENHA'
glpi_database=glpiBD

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-ocs_glpi-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup OCS e GLPi iniciado em $HORAINICIAL.                                             |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

# Verifique uma montagem
#mount_verify=yes
#mount_dir=/home/administrador/backup
echo "Sistema de backup do GLPI e OCS Inventory NG" >>"$LOG"
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
mkdir /tmp/backup-ocs-glpi &>/dev/null
rm -Rfv /tmp/backup-ocs-glpi/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-ocs-glpi/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-ocs-glpi" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-ocs-glpi" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados OCS Inventory
echo "Despejo de inventário OCS NG" >>"$LOG"
mysqldump -h$ocs_server -u$ocs_user -p$ocs_password $ocs_database >/tmp/backup-ocs-glpi/ocs_database_$current_date.sql

# MySQLDUMP do banco de dados GLPI
echo "Despejo da base GLPI" >>"$LOG"
mysqldump -h$glpi_server -u$glpi_user -p$glpi_password $glpi_database >/tmp/backup-ocs-glpi/glpi_database_$current_date.sql

# Cópia de GLPI no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório GLPI" >>"$LOG"
rsync -az $glpi_dir /tmp/backup-ocs-glpi
echo "Alterando o nome do diretório GLPI" >>"$LOG"
mv /tmp/backup-ocs-glpi/glpi /tmp/backup-ocs-glpi/glpi-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-ocs-glpi &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -az /tmp/backup-ocs-glpi $backup_dir

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-ocs-glpi &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-ocs_glpi-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-ocs-glpi/ &>/dev/null
scp -P PORTA /mnt/server_backup/backup-ocs_glpi-$(date +%Y%m%d).tar.gz administrador@SEU_IP:/mnt/Storage/Backups/OCS-GLPI/

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

