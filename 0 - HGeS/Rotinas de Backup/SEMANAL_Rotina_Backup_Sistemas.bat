@echo off
@rem muda a cor da tela do script
@color 73

@title "Iniciando o Backup dos Sistemas"
@echo ------------------------------
@echo Iniciando Backup dos Sistemas
@echo ------------------------------
@echo Iniciando copia dos arquivos dos servidores para a pasta local em H:\Backups\Aplicacao

rar u "H:\Backups\Aplicacao\simatexom.rar" "\\10.1.18.2\f$\simatexom"
rar u "H:\Backups\Aplicacao\sismacon.rar" "\\10.1.18.7\c$\xampp\htdocs\sismacon"
rar u "H:\Backups\Aplicacao\sistrad.rar" "\\10.1.18.7\c$\xampp\htdocs\sistrad"
rar u "H:\Backups\Aplicacao\frad.rar" "\\10.1.18.7\c$\xampp\htdocs\frad"
rar u "H:\Backups\Aplicacao\dados.rar" "\\10.1.18.7\c$\Program Files\Intelbras\Controller\BIN\INTEGRA"
rar u "H:\Backups\Aplicacao\sgh.rar" "\\10.1.18.1\g$\sgh"

@rem muda o titulo
@title "Backup dos Sistemas Finalizado"

@rem imprime uma mensagem na tela
@echo --------------------------------
@echo "backup dos sistemas finalizado"
@echo --------------------------------

@echo ++++++++++++++++++++++++++++++++++++++

@rem fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit