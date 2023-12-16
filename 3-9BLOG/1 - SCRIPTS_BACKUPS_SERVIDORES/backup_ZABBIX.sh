#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_ZABBIX.sh                              #
# Descrição      :   Backup do Servidor de Gerenciamento de Rede.  #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_ZABBIX.sh                          #
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
zabbix_dir=/usr/share/zabbix

# BDD intranet identificadores
zabbix_server=localhost
zabbix_user=zabbix
zabbix_password='SUA_SENHA'
zabbix_database=zabbix

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-zabbix-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup ZABBIX iniciado em $HORAINICIAL.                                                 |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

echo "Sistema de backup ZABBIX" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

# Criação de uma pasta temporária e esvaziamento dela
echo "Criação da pasta temporária" >>"$LOG"
mkdir /tmp/backup-zabbix &>/dev/null
rm -Rfv /tmp/backup-zabbix/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-zabbix/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-zabbix" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-zabbix" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados intranet
echo "Despejo de inventário ZABBIX " >>"$LOG"
mysqldump -h$zabbix_server -u$zabbix_user -p$zabbix_password $zabbix_database >/tmp/backup-zabbix/zabbix_database_$current_date.sql

# Cópia de intranet no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório ZABBIX" >>"$LOG"
rsync -azP $zabbix_dir /tmp/backup-zabbix >>"$LOG"
echo "Alterando o nome do diretório ZABBIX" >>"$LOG"
mv /tmp/backup-zabbix/zabbix /tmp/backup-zabbix/zabbix-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-zabbix &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -azP /tmp/backup-zabbix $backup_dir >>"$LOG"

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-zabbix &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-zabbix-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-zabbix/ &>/dev/null
scp -P PORTA /mnt/server_backup/backup-zabbix-$(date +%Y%m%d).tar.gz administrador@SEU_IP:/mnt/Storage/Backups/ZABBIX/

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

cp -rf $dir_log/$arq_log $destino
rm -Rfv /mnt/server_backup/*.tar.gz

exit 1
