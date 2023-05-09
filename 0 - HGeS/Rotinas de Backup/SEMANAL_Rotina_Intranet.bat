@echo off
@rem muda a cor da tela do script
@color 73
@title "Iniciando o Backup Servidores"

@echo ---------------------------
@echo Iniciando Backup Intranet
@echo ---------------------------
@echo Iniciando copia dos arquivos dos servidores para a pasta local em H:\Backups\Aplicacao

@echo Iniciando Backup Intranet
rar u -agyyyymmdd -inul "H:\Backups\Aplicacao\"Intranet_ "\\10.1.18.2\f$\xampp\htdocs\intranet"

@rem muda o titulo
@title "Backup da Intranet Finalizado"

@rem imprimi uma mensagem na tela
@echo --------------------------------
@echo "Backup da Intranet finalizado"
@echo --------------------------------

@echo ++++++++++++++++++++++++++++++++++++++
@title "Testando arquivos de Backup"
@echo -----------------------
@echo Iniciando teste
@echo -----------------------
@echo Iniciando teste

rar t -r H:\Backups\Aplicacao\*.rar


@rem muda o titulo
@title "Teste Finalizado"

@rem imprime uma mensagem na tela
@echo -----------------------
@echo "Teste finalizado!"
@echo -----------------------

@rem fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit
