@echo off
@rem muda a cor da tela do script
@color 81

@title "Iniciando o Backup Publico"
@echo -----------------------
@echo Iniciando Backup Publico
@echo -----------------------
@echo Movendo os arquivos do Publico para pasta local em f:\Backups\Publico

rar m -r "H:\Backups\Publico\publico.rar" "\\10.1.18.1\d$\Publico\*"


@rem muda o titulo
@title "Backup do Publico Finalizado"

@rem  imprimi uma mensagem na tela
@echo -----------------------
@echo "backup publico finalizado"
@echo -----------------------
@rem  fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit
