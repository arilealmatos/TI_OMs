
#Script desenvolvido para agilizar o processo de migração e atualização dos computadores com sistemas GNU\Linux no setor de Informática do HGeS.  >>> VERSÃO 11.0 <<<

#Verifica se o usuário é root
if [ "`id -u`" != "0" ] ; then
zenity --error --text="Precisa ser root!"
exit
fi

# Lista de seleção de scripts
ITEM_SELECIONADO=$(zenity  --list --title="Opções do Administrador" --height="250" --width="400" --text "Uso restrito aos técnicos da seção de informatica" \
    --radiolist \
    --column "" \
    --column "Opção" \
    FALSE Desativar-midias-de-armazenamento FALSE Ativar-midias-de-armazenamento FALSE Mudar-maquina-de-setor FALSE Corrigir-RI FALSE Sair-do-dominio FALSE Ingressar-no-dominio);
cd /usr/share/HGeS
./$ITEM_SELECIONADO.sh
