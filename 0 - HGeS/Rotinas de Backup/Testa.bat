@echo off
@rem muda a cor da tela do script
@color 81

@title "Testando arquivos de Backup"
@echo -----------------------
@echo Iniciando teste
@echo -----------------------
@echo Iniciando teste

rar t -r c:\Backups\*.rar


@rem muda o titulo
@title "Teste Finalizado"

@rem imprimi uma mensagem na tela
@echo -----------------------
@echo "Teste finalizado!"
@echo -----------------------
@rem fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit
