@echo off  
 
for /f "tokens=1-4 delims=/ " %%a IN ('DATE /T') do (set MYDATE=%%a%%b%%c%%d)
for /f "tokens=1-2 delims=: " %%a in ('TIME /T') do (set MYTIME=%%ah%%bm)
  
SET MYSQL_PATH="C:\Windows\system32"
SET MYSQL_USER=root	
SET MYSQL_PASS=H0sp#1788#R34l
   
SET MYSQL_HOST=10.1.18.13
SET MYSQL_PORT=3306
SET NOME_ARQUIVO=sisbol.%MYDATE%.%MYTIME%.sql  
     
SET ARQUIVO="H:\Backups\Aplicacao\%NOME_ARQUIVO%" 
   
SET MYSQL_DATABASE=cta
   
@echo iniciando o backup...
@echo.
  
%MYSQL_PATH%\mysqldump.exe -v -v -v --host=%MYSQL_HOST% --user=%MYSQL_USER% --password=%MYSQL_PASS% --port=%MYSQL_PORT% --protocol=tcp --force --allow-keywords --compress  --add-drop-table --default-character-set=latin1 --hex-blob --result-file=%ARQUIVO% %MYSQL_DATABASE%
 
@echo.
 
@echo compactando o arquivo...
@echo.
@echo |TIME /T
@echo.
cd \
cd D:\Rotinas de Backup
RAR a  "H:\Backups\Aplicacao\%NOME_ARQUIVO%.RAR" "H:\Backups\Aplicacao\Notas\*.sql"
@echo.
@echo Excluindo arquivo de apoio...
del "H:\Backups\Aplicacao\Notas\*.sql"
 
@echo.
@echo |TIME /T
@echo.
 
@echo finalizando o backup...
@echo.