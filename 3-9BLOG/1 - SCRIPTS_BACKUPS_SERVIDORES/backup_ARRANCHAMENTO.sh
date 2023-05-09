#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_ARRANCHAMENTO.sh                       #
# Descrição      :   Backup do Sistema de Arranchamento.           #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_ARRANCHAMENTO.sh                   #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 23/04/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inicio e Fim                       #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #
# Arquivo de recibo de backup
backup_dir=/home/administrador/backup

# Pasta contém arquivos ARRANCHAMENTO
arranchamento_dir=/var/www/html/Arranchamento

# BDD OCS Inventory NG identifiers
#ocs_server=localhost
#ocs_user=ocs
#ocs_password=''
#ocs_database=ocs

# Identificadores BDD ARRANCHAMENTO
arranchamento_server=localhost
arranchamento_user=root
arranchamento_password='S4nt@Bl0g*1973'
arranchamento_database=rancho

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-rancho-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup ARRANCHAMENTO iniciado em $HORAINICIAL.                                          |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

# Verifique uma montagem
#mount_verify=yes
#mount_dir=/home/administrador/backup
echo "Script de backup do ARRANCHAMENTO" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
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
mkdir /tmp/backup-arranchamento &>/dev/null
rm -Rfv /tmp/backup-arranchamento/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-arranchamento/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-arranchamento" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-arranchamento" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados OCS Inventory
#echo "Despejo de inventário OCS NG"
#mysqldump -h$ocs_server -u$ocs_user -p$ocs_password $ocs_database > /tmp/backup-glpi/ocs_database_$current_date.sql

# MySQLDUMP do banco de dados ARRANCHAMENTO
echo "Despejo da base ARRANCHAMENTO" >>"$LOG"
mysqldump -h$arranchamento_server -u$arranchamento_user -p$arranchamento_password $arranchamento_database >/tmp/backup-arranchamento/arranchamento_database_$current_date.sql

# Cópia de ARRANCHAMENTO no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório ARRANCHAMENTO" >>"$LOG"
rsync -az $arranchamento_dir /tmp/backup-arranchamento
echo "Alterando o nome do diretório ARRANCHAMENTO" >>"$LOG"
mv /tmp/backup-arranchamento/arranchamento /tmp/backup-arranchamento/arranchamento-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-arranchamento &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -azP /tmp/backup-arranchamento $backup_dir >>"$LOG"

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-arranchamento &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-arranchamento-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-arranchamento &>/dev/null
scp -P 173 /mnt/server_backup/backup-arranchamento-$(date +%Y%m%d).* administrador@10.26.68.6:/mnt/Storage/Backups/ARRANCHAMENTO/

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
