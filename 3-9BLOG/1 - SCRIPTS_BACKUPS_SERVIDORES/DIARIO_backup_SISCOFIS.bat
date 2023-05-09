@echo off
@rem muda a cor da tela do script
@color 81

:: # ---------------------------------------------------------------- #
:: # Nome do Script :   DIARIO_COPIA_SISCOFIS.bat                     #
:: # Descrição      :   Backup LOCAL SISCOFIS.                       #
:: # Site           :   http://intranet.9blog.eb.mil.br               #
:: # Escrito por    :   1º Sgt L. Matos                               #
:: # Manutenido por :   1º Sgt L. Matos                               #
:: # ---------------------------------------------------------------- #
:: # Forma de Uso   :   DIARIO_COPIA_SISCOFIS.bat                     #
:: # ---------------------------------------------------------------- #
:: # Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
:: #                     - Cabeçalho                                  #
:: # ---------------------------------------------------------------- #
:: # Agradecimentos :                                                 #
:: # SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
:: # ---------------------------------------------------------------- #

REM - Criado por: 1ºSGT L MATOS

REM - VARIAVEIS
set LOG=C:\Backups\SISCOFIS\LOG
set data=%date:~6,4%%date:~3,2%%date:~0,2%
set hora=%time:~0,2%%time:~3,2%

REM - ESTRUTURA
@title "Iniciando o Backup SIMATEx OM"  > %LOG%\"log_%data%_%hora%.txt"
@echo ----------------------------      >> %LOG%\"log_%data%_%hora%.txt"
@echo Iniciando Backup SISCOFIS         >> %LOG%\"log_%data%_%hora%.txt"
@echo ----------------------------      >> %LOG%\"log_%data%_%hora%.txt"

::del "C:\Backups\SISCOFIS\*.rar"
del C:\Backups\SISCOFIS\*.rar
@echo Apagado arquivo de backup SISCOFIS antigo local. >> %LOG%\"log_%data%_%hora%.txt"
::del "C:\Backups\SISCOFIS\BackupSimatexOm_*.BKP"
::del C:\Backups\SISCOFIS\*.BKP
@echo Apagado arquivo de backup Banco de Dados antigo local. >> %LOG%\"log_%data%_%hora%.txt"
::rar u -agyyyymmdd -inul "C:\Backups\SISCOFIS\simatexom_.rar" "C:\SimatexOm"
rar u -agyyyymmdd -inul C:\Backups\SISCOFIS\simatexom_.rar C:\SimatexOm
@echo Executada copia e compactacao da pasta SISCOFIS. >> %LOG%\"log_%data%_%hora%.txt"

@echo ---------------------------- >> %LOG%\"log_%data%_%hora%.txt"
@echo Backup SISCOFIS finalizado. >> %LOG%\"log_%data%_%hora%.txt"
@echo ---------------------------- >> %LOG%\"log_%data%_%hora%.txt"

exit /b
@pause
@exit
timeout 10

