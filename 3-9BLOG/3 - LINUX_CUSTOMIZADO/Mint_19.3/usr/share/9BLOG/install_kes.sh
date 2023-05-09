#!/bin/bash
#Editado 20/11/2018

function uninstall_previous_kaspersky_installations() {
	echo -e "\n\n:: Desinstalando instância do Agente de rede do Kaspersky  ::"
	if [ ! "$(pgrep klnagent)" = '' ]; then
		kill $(pgrep klnagent)
	fi
	sleep 5s
	dpkg -P klnagent klnagent64

        echo -e "\n\n:: Desinstalando instância do Kaspersky Endpoint Security ::"
        if [ ! "$(pgrep kesl)" = '' ]; then
                kill $(pgrep kesl)
        fi
        sleep 5s
        dpkg -P kesl
}


function install_network_agent() {
	echo -e "\n\n:: Instalando Kaspersky Network Agent ::"

	if [ "$(uname -m)" = 'x86_64' ] ; then
	dpkg -i klnagent64_10.5.0-42_amd64.deb
	cp autoanswers.conf /opt/kaspersky/klnagent64/lib/bin/setup/
	/opt/kaspersky/klnagent64/lib/bin/setup/postinstall.pl --auto
	fi

	if [ "$(uname -m)" = 'i386' ] || [ "$(uname -m)" = 'i686' ] ; then   
	dpkg -i klnagent_10.5.1-7_i386.deb
	cp autoanswers.conf /opt/kaspersky/klnagent64/lib/bin/setup/
	/opt/kaspersky/klnagent/lib/bin/setup/postinstall.pl --auto
	fi
}


function install_endpoint_kes() {
	echo -e "\n\n:: Instalando Kaspersky Endpoint Security ::"
	
	if [ "$(uname -m)" = 'x86_64' ] ; then
        dpkg -i kesl_10.1.0-5960_amd64.deb
	/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=kesconfig.load
	fi
	
	if [ "$(uname -m)" = 'i386' ] || [ "$(uname -m)" = 'i686' ] ; then
	dpkg -i kesl_10.1.0-5960_i386.deb
	/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=kesconfig.load
	fi

	echo -e "\nO Kaspersky Network Agent e o Endpoint Security foram instalados com sucesso."
}

uninstall_previous_kaspersky_installations
install_network_agent
install_endpoint_kes

echo -e "\n\nInstalação concluída. Reinicie o computador"

