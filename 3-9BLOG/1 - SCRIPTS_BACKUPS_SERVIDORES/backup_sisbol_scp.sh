#!/bin/bash
# 
# ---------------------------------------------------------------- #
# Nome do Script :   backup_sisbol_scp.sh                          #
# Descrição      :   Backup SISBOL com SCP.                        #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   2º Sgt Conrado <hugoconrado777@gmail.com>     #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./backup_sisbol_scp.sh                      #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

# Declaração de variáveis:
DATA=`date +'%d-%m-%Y-%H-%M'`
DB=cta
USUARIO=root
SENHA=vertrigo
DIR_LOCAL=/mnt/backup_server/sisbol
HOST_REMOTO=administrador@10.26.68.6
DIR_REMOTO=/mnt/Storage/Backups/Backups_SISBOL
#HOST_REDUNDANCIA=sti@10.79.28.75
#DIR_REDUNDANCIA=/var/backups/sistemas/sisbol
ARQUIVO_LOG="log-backup-sisbol-$DATA.txt"
RAIZ_SISBOL=/var/www/band
QTD=3

# Inicialização do log:
LOG="$DIR_LOCAL"/"$ARQUIVO_LOG"
echo "Backup do SisBol realizado em $(date +'%d/%m/%y %H:%M')." >"$LOG"
STATUS=0

# Para o servidor Apache, para evitar acessos durante o backup.
service apache2 stop

# Faz o dump da base de dados do MySQL:
CAMINHO_SQL="$DIR_LOCAL"/bkpSisBol-$DATA.sql
echo "Criando dump da base de dados do SisBol..." >>$LOG
if mysqldump -u "$USUARIO" -p"$SENHA" -v -B "$DB" "$DB" > "$CAMINHO_SQL" 2>>$LOG;
then	echo "Dump do banco de dados realizado com sucesso." >>$LOG
else	echo "Erro ao realizar o dump do banco de dados." >>$LOG
		(( STATUS += 1 ))
fi

# Compacta e salva o conteúdo das três pastas de PDF gerados no SisBol:
# alteracao, boletim, ficha e nota_boletim.
CAMINHO_PDF="$DIR_LOCAL"/bkpPDF-$DATA.tar.gz
echo "Criando arquivo compactado com os PDFs..." >>$LOG
tar zcvfp "$CAMINHO_PDF" "$RAIZ_SISBOL"/alteracao "$RAIZ_SISBOL"/boletim "$RAIZ_SISBOL"/ficha "$RAIZ_SISBOL"/nota_boletim >>$LOG

# Se foi criado o arquivo corretamente, o envia ao servidor remoto..
if [ $? -eq 0 ]
then	echo "Arquivos PDF copiados com sucesso." >>$LOG
else	echo "Erro ao criar a cópia dos arquivos PDF.">>$LOG
		(( STATUS += 2 ))
fi

# Criação das pastas no servidor remoto:
echo "Criando diretórios no servidor remoto...">>$LOG
DIR_REMOTO="$DIR_REMOTO"/$(date +%d-%m-%Y)
ssh -p173 "$HOST_REMOTO" mkdir "$DIR_REMOTO" 2>>$LOG
#DIR_REMOTO=$DIR_REMOTO/sisbol
#ssh "$HOST_REMOTO" mkdir "$DIR_REMOTO" 2>> $LOG

# Verifica se foram criados corretamente. Se não foram criados, interrompe o backup.
if ssh -p173 "$HOST_REMOTO" test -d "$DIR_REMOTO" 2>>$LOG;
then	echo "Diretórios criados com sucesso.">>$LOG
else	echo "Erro: os diretórios no servidor remoto não foram criados." >>$LOG
		(( STATUS += 4 ))
fi

ST_CP=0
if (( ( ( STATUS / 4 ) % 2 ) == 0 ))
then	scp -P 173 "$CAMINHO_SQL" "$HOST_REMOTO":"$DIR_REMOTO" 2>>$LOG
	(( ST_CP += $? ))
	scp -P 173 "$CAMINHO_PDF" "$HOST_REMOTO":"$DIR_REMOTO" 2>>$LOG
	(( ST_CP += $? ))
	scp -P 173 "$CAMINHO_SQL" "$HOST_REDUNDANCIA":"$DIR_REDUNDANCIA" 2>>$LOG
	#scp "$CAMINHO_PDF" "$HOST_REDUNDANCIA":"$DIR_REDUNDANCIA" 2>>$LOG
	
else	echo "Erro: o diretório remoto não eh acessível" >>$LOG
	(( ST_CP = 1 ))
fi

echo "Removendo backups antigos do servidor local..." >>$LOG
cd "$DIR_LOCAL"
echo "PWD = $(pwd)" >>$LOG;

cd $DIR_LOCAL
if [ `ls $DIR_LOCAL | wc -w` -gt $QTD ];
then	echo "Ha $QTD ou mais arquivos no diretorio. Removendo os mais antigos..." >>$LOG;
	LISTA=( `ls -t $DIR_LOCAL` )
	for arquivo in ${LISTA[@]:$QTD}; do
		echo "Removendo o arquivo $arquivo..." >>$LOG
		rm -r $DIR_LOCAL/$arquivo;
	done
else 	echo "Ha menos de $QTD arquivos no diretorio. Nao ha arquivos a serem removidos." >>$LOG;
fi

if [ `ls $DIR_LOCAL | wc -w` -gt $QTD ];
then	echo "Atencao: ainda ha arquivos em excesso no diretorio!" >>$LOG
	(( STATUS += 16 ))
else	echo "O diretorio contem a quantidade adequada de arquivos." >>$LOG
	echo "Backup concluido e arquivos copiados para o servidor remoto." >>$LOG
fi

if (( ST_CP == 0 ))
then	echo "Copia para o servidor remoto concluida." >>$LOG
	# Reinicia o servidor Apache:
else	echo "Erro: os arquivos nao foram copiados para o servidor remoto" >>$LOG
		(( STATUS += 8 ))
fi


echo "Reiniciando o Apache..." >>$LOG
if /etc/init.d/apache2 restart 2>>$LOG;
then	echo "Apache reiniciado com sucesso." >>$LOG;
else	echo "Erro ao iniciar o servidor Apache." >>$LOG;
fi
echo "Procedimento concluido em $(date +'%H:%M %d/%m/%Y')." >>$LOG
if [[ $STATUS -ne 0 ]]
then	echo "Codigo de erros: $STATUS" >>$LOG
fi
scp -P 173 "$LOG" "$HOST_REMOTO":"$DIR_REMOTO"
#scp "$LOG" "$HOST_REDUNDANCIA":"$DIR_REDUNDANCIA"
exit 0




#echo "Fazendo remocao suplementar." >>$LOG;
#if [ `ls | wc -w` -gt $QTD ];
#then	echo "Ha mais de $QTD arquivos."
#	LISTA=( `ls -t $DIR_LOCAL` )
#	for arquivo in ${LISTA[@]:$QTD}; do
#		echo "Arquivo $arquivo"
#		echo "rm -r $DIR_LOCAL/$arquivo";
#		rm -r $DIR_LOCAL/$arquivo;
#	done
#else	echo "Ha $QTD ou menos arquivos. Nao e necessario apagar.";
#fi

exit $STATUS

