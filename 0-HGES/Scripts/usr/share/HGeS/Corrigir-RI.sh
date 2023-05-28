#!/bin/bash

#Script desenvolvido para agilizar o processo de migração e atualização dos computadores com sistemas GNU\Linux no setor de Informática do HGeS.  >>> VERSÃO 11.0 <<<

RI=$(zenity --title="Alterar RI" --text "Digite o RI correto da máquina" --entry)
	sed -i "s/tag=.*/tag=$RI/" /etc/ocsinventory/ocsinventory-agent.cfg
