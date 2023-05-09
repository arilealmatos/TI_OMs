@echo off
ECHO.
echo Realizando backup do GLPI....
\\10.1.18.2\f$\xampp\mysql\bin\mysqldump -u root --password=ms17823094 --lock-tables=false glpi > glpi.sql
echo Realizando backup do GLPI....
ECHO.

@rem fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit
