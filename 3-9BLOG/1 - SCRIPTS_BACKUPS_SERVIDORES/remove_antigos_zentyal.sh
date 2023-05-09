#!/bin/bash

#Remove Arquivos e Pastas do Servidor com mais de 6 dias
find /mnt/Storage/Backups/Servidor/* -exec rm -rf "{}" \;
