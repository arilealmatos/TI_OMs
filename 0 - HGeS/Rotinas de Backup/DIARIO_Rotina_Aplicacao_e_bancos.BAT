@echo off
@rem muda a cor da tela do script
@color 81
@title "Iniciando o Backup Servidores"
@title "Iniciando o Backup Aplicaçao"
@echo -----------------------
@echo Iniciando Backup Aplicaçao
@echo -----------------------
@echo Iniciando copia dos arquivos dos servidores para a pasta local em f:\Backups\Aplicacao

@echo Iniciando Backup Aplicaçao e banco Modulo E1
rar u -agyyyymmdd -inul "F:\Backups\Aplicacao\"ModuloE1_ "\\10.1.18.2\f$\E12007"
@echo Iniciando Backup Aplicaçao GLPI
rar u -agyyyymmdd -inul "F:\Backups\Aplicacao\"glpi_ "\\10.1.18.2\f$\xampp\htdocs\glpi"
@echo Iniciando Backup Aplicaçao e Banco Simatex
rar u -agyyyymmdd -inul "F:\Backups\Aplicacao\"simatexom_ "\\10.1.18.2\f$\simatexom"


@rem muda o titulo
@title "Backup da Aplicaçao Finalizado"

@rem imprimi uma mensagem na tela
@echo -----------------------
@echo "Backup da Aplicaçao finalizado"
@echo -----------------------

@echo ++++++++++++++++++++++++++++++++++++++

@title "Iniciando o Backup Bancos"
@echo -----------------------
@echo Iniciando Backup Bancos
@echo -----------------------
@echo Iniciando copia dos arquivos do servidor para pasta local em F:\Backups\Bancos

rar m "F:\Backups\Bancos\bancos_02.rar" "\\10.1.18.2\f$\Backups\*.rar"


@rem muda o titulo
@title "Backup de bancos Finalizado"

@rem imprimi uma mensagem na tela
@echo -----------------------
@echo "backup bancos finalizado"
@echo -----------------------

@echo ++++++++++++++++++++++++++++++++++++++
@title "Testando arquivos de Backup"
@echo -----------------------
@echo Iniciando teste
@echo -----------------------
@echo Iniciando teste

rar t -r f:\Backups\Aplicacao\*.rar


@rem muda o titulo
@title "Teste Finalizado"

@rem imprimi uma mensagem na tela
@echo -----------------------
@echo "Teste finalizado!"
@echo -----------------------
@rem fecha o script quando terminar, voc pode usar o comando pause ou exit
@pause
@exit
