#!/bin/bash
 
# ---------------------------------------------------------------- #
# Nome do Script :   install.sh                                    #
# Descrição      :   Modulo de Protecao Cibernetica.               #
# Site           :   http://intranet.9blog.eb.mil.br               #
# Escrito por    :   41CT | 1º Sgt L. Matos                        #
# Manutenido por :   1º Sgt L. Matos                               #
# ---------------------------------------------------------------- #
# Forma de Uso   :   # ./install.sh                                #
# ---------------------------------------------------------------- #
# Histórico      :   v4.0 14/11/2021, 1º Sgt L. Matos:             #
#                     - Cabeçalho                                  #
# ---------------------------------------------------------------- #
# Agradecimentos :                                                 #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log  #
# ---------------------------------------------------------------- #

# Variables
MACHINE_TYPE=`uname -m`
KERNEL_TYPE=`uname -r`

clear;
echo "";

# Mensagem Inicial
echo -e "###################################";
echo -e "\n\n*** STI 9 B Log ***\n\n";
echo -e "Modulo de Protecao Cibernetica\n";
echo -e "###################################\n\n";

#configura Proxy no computador
echo -e "Configuracao de Proxy no sistema para APT-CACHER ...";
export http_proxy="http://10.26.68.10:3142";
export https_proxy="http://10.26.68.10:3142";
export ftp_proxy="http://10.26.68.10:3142";

#atualiza lista de pacotes
echo -e "Atualizando lista de pacotes...";
apt-get update -y;
wait

#Correcao caso haja pacotes quebrados
apt-get -f install -y;
wait

#instalacao PERL
apt-get install perl -y;
wait

#Correcao caso haja pacotes quebrados
apt-get -f install -y;
wait

#instalacao dependencias GUI
apt-get install libfontconfig1 libfreetype6 libice6 libsm6 libx11-6 libx11-xcb1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render0 libxcb-render-util0 libxcb-shape0 libxcb-shm0 libxcb1 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 libxi6 libxml2 libxcb-xinerama0 -y;
wait

#Correcao caso haja pacotes quebrados
apt-get -f install -y;
wait

#instala headers do kernel
echo -e "Instalando headers do Kernel ...";
apt-get install linux-headers-$KERNEL_TYPE -y;
wait

#Correcao caso haja pacotes quebrados
apt-get -f install -y;
wait

#instala pacotes necessários para o antivirus
#Install agent kaspersky
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    # 64-bit stuff here
    apt-get install -y build-essential libc6 libc6-dev wget -y;
    wait
else
    # 32-bit stuff here
    apt-get install -y build-essential libc6-i386 libc6-dev-i386 -y;
    wait
fi

#Correcao caso haja pacotes quebrados
apt-get -f install -y;
wait

#Install agent kaspersky
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
  echo "Instalando Agente Kaspersky para arquitetura de 64 bits...";


  dpkg -i klnagent64_12.0.0-60_amd64.deb;
  wait

  apt-get -f install -y;
  wait

  printf '10.25.108.40\n14000\n13000\nN\n1' | perl /opt/kaspersky/klnagent64/lib/bin/setup/postinstall.pl;
  wait
  /opt/kaspersky/klnagent64/bin/klmover -address 10.25.108.40;
else
  # 32-bit stuff here
  echo "Instalando Agente Kaspersky para arquitetura de 32 bits...";

  dpkg -i klnagent_12.0.1-60_i386.deb;
  wait

  apt-get -f install -y;
  wait

  printf '10.25.108.40\n14000\n13000\nN\n1' | perl /opt/kaspersky/klnagent/lib/bin/setup/postinstall.pl;
  wait
  /opt/kaspersky/klnagent/bin/klmover -address 10.25.108.40;
fi

wait
#

#install kesl
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  # 64-bit stuff here
  echo "Instalando Antivirus Kaspersky para arquitetura de 64 bits...";

  dpkg -i kesl_11.2.0-4528_amd64.deb;
  wait

  apt-get -f install -y;
  wait

  printf 'pt_BR.UTF-8\n\ny\ny\nn\ny' | perl /opt/kaspersky/kesl/bin/kesl-setup.pl;
  wait

else
  # 32-bit stuff here
  echo "Instalando Antivirus Kaspersky para arquitetura de 32 bits...";

  dpkg -i kesl_11.2.0-4528_i386.deb;
  wait

  apt-get -f install -y;
  wait

  printf 'pt_BR.UTF-8\n\ny\ny\nn\ny' | perl /opt/kaspersky/kesl/bin/kesl-setup.pl;
  wait
fi

#reboot em 5 min
echo -e "\n\n\n############################\n\n\n";
echo -e "*** Computador precisa ser REINICIADO MANUALMENTE ***";
echo -e "\n\n\n############################\n\n\n";



