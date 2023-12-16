#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_SACVOM.sh                              #
# Descrição      :   Backup do SACVOM.                             #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_SACVOM.sh                          #
# ---------------------------------------------------------------- #
# Histórico      :   v5.0 23/04/2023, 1º Sgt L. Matos:             #
#                     - Hora de Inicio e Fim                       #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #
# Arquivo de recibo de backup
backup_dir=/home/administrador/backup

# Pasta contém arquivos SACVOM
sacvom_dir=/var/www/html/

# BDD sacvom identificadores
sacvom_server=localhost
sacvom_user=sacvom
sacvom_password='SUA_SENHA'
sacvom_database=sacvom

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-sacvom-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "|Backup SACVOM iniciado em $HORAINICIAL.                                                  |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

echo "Sistema de backup sacvom" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

# Criação de uma pasta temporária e esvaziamento dela
echo "Criação da pasta temporária" >>"$LOG"
mkdir /tmp/backup-sacvom &>/dev/null
rm -Rfv /tmp/backup-sacvom/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-sacvom/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-sacvom" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-sacvom" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados sacvom
echo "Despejo de inventário sacvom" >>"$LOG"
mysqldump -h$sacvom_server -u$sacvom_user -p$sacvom_password $sacvom_database >/tmp/backup-sacvom/sacvom_database_$current_date.sql

# Cópia de SACVOM no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório SACVOM" >>"$LOG"
rsync -az $sacvom_dir /tmp/backup-sacvom
echo "Alterando o nome do diretório SACVOM" >>"$LOG"
mv /tmp/backup-sacvom/sacvom /tmp/backup-sacvom/sacvom-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-sacvom &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -azP /tmp/backup-sacvom $backup_dir >>"$LOG"

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-sacvom &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-sacvom-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-sacvom/ &>/dev/null
scp -P PORTA /mnt/server_backup/backup-sacvom-$(date +%Y%m%d).tar.gz administrador@SEU_IP:/mnt/Storage/Backups/SACVOM/

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
