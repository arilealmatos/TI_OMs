#!/bin/bash
#
# ---------------------------------------------------------------- #
# Nome do Script :   backup_TEAMPASS.sh                            #
# Descrição      :   Backup do Gerenciador de Senhas TeamPass.     #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   Benjamin Mercier - teclib '<www.teclib.com>   #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_TEAMPASS.sh                        #
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
teampass_dir=/var/www/html/

# BDD intranet identificadores
teampass_server=localhost
teampass_user=root
teampass_password='S4nt@Bl0g*1973'
teampass_database=teampass

# Hora Inicial
HORAINICIAL=$(date +%T)

#Log
dir_log=/home/administrador/LOGs
arq_log="backup-teampass-$(date +%d-%m-%Y_%H-%M).txt"

#Inicializando o Log
LOG="$dir_log"/"$arq_log"
echo "---------------------------------------------------------------------------------------" >"$LOG"
echo "| Backup TeamPass iniciado em $HORAINICIAL.                                               |" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"
status=0

echo "Sistema de backup TeamPass" >>"$LOG"
echo "Script desenvolvido por Benjamin Mercier - teclib '<www.teclib.com>" >>"$LOG"
echo "---------------------------------------------------------------------------------------" >>"$LOG"

# Criação de uma pasta temporária e esvaziamento dela
echo "Criação da pasta temporária" >>"$LOG"
mkdir /tmp/backup-teampass &>/dev/null
rm -Rfv /tmp/backup-teampass/* &>/dev/null

# Alteração de diretório
echo "Alteração de diretório" >>"$LOG"
cd /tmp/backup-teampass/ &>/dev/null
pwd=$(pwd)
if [[ "$pwd" != "/tmp/backup-teampass" ]]; then
        echo "ERRO: Não foi possível acessar /tmp/backup-teampass" >>"$LOG"
        exit 1
fi

# Data atual
current_date=$(date +%Y-%m-%d_%H-%M)

# MySQLDUMP do banco de dados intranet
echo "Despejo de inventário TeamPass " >>"$LOG"
mysqldump -h$teampass_server -u$teampass_user -p$teampass_password $teampass_database >/tmp/backup-teampass/teampass_database_$current_date.sql

# Cópia de intranet no RSYNC
# É possível copiá-lo de um servidor remoto
echo "Cópia do diretório teampass" >>"$LOG"
rsync -az $teampass_dir /tmp/backup-teampass
echo "Alterando o nome do diretório teampass" >>"$LOG"
mv /tmp/backup-teampass/teampass /tmp/backup-teampass/teampass-$current_date &>/dev/null

#dump do diretório de backup
echo "Esvaziando o diretório remoto" >>"$LOG"
rm -Rfv $backup_dir/backup-teampass &>/dev/null

# Cópia de todos os arquivos no backup
echo "Transferir para o servidor de backup" >>"$LOG"
rsync -az /tmp/backup-teampass $backup_dir

# Exclua o diretório
echo "Excluir diretório temporário" >>"$LOG"
rm -Rfv /tmp/backup-teampass &>/dev/null

# Compactando pasta e arquivos
echo "Criando arquivo .tar.gz." >>"$LOG"
tar zcvf /mnt/server_backup/backup-teampass-$(date +%Y%m%d).tar.gz /home/administrador/backup/backup-teampass/ &>/dev/null
scp -P 173 /mnt/server_backup/backup-teampass-$(date +%Y%m%d).tar.gz administrador@10.26.68.6:/mnt/Storage/Backups/TEAMPASS/

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
