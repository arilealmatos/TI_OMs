@echo off
@rem muda a cor da tela do script
@color 81

:: # ---------------------------------------------------------------- #
:: # Nome do Script :   DIARIO_COPIA_SISCOFIS.bat                     #
:: # Descrição      :   Backup Remoto SISCOFIS.                       #
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
@title "Iniciando COPIA DE ARQUIVO SIMATEx OM"  > %LOG%\"WinSCP_%data%_%hora%.log"
@echo ----------------------------      >> %LOG%\"WinSCP_%data%_%hora%.log"
@echo Iniciando COPIA SISCOFIS         >> %LOG%\"WinSCP_%data%_%hora%.log"
@echo ----------------------------      >> %LOG%\"WinSCP_%data%_%hora%.log"


"C:\Program Files\WinSCP\WinSCP.exe" ^
  /log="C:\Backups\SISCOFIS\LOG\WinSCP_%data%_%hora%.log" /ini=nul ^
  /command ^
    "open sftp://administrador:SUA_SENHA@SEU_IP:PORTA/mnt/Storage/Backups/Backups_SIMATEx/ -hostkey=""ssh-ed25519 255 tqoxS23qq7d9XRmk5C/WEL/nxK73/fLIOiHRt5yL5KM="" -rawsettings FSProtocol=2" ^
    "put C:\Backups\SISCOFIS\simatexom*.*" ^
    "exit"
@echo Executada COPIA DE ARQUIVO PARA BACKUP. >> %LOG%\"WinSCP_%data%_%hora%.log"

set WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
  @echo ---------------------------- >> %LOG%\"WinSCP_%data%_%hora%.log"
  @echo COPIA SISCOFIS finalizada com SUCESSO. >> %LOG%\"WinSCP_%data%_%hora%.log"
  @echo ---------------------------- >> %LOG%\"WinSCP_%data%_%hora%.log"
  echo Success
) else (
  @echo ---------------------------- >> %LOG%\"WinSCP_%data%_%hora%.log"
  @echo COPIA SISCOFIS finalizada com FALHA. >> %LOG%\"WinSCP_%data%_%hora%.log"
  @echo ---------------------------- >> %LOG%\"WinSCP_%data%_%hora%.log"
  echo Error
)

exit /b %WINSCP_RESULT%
