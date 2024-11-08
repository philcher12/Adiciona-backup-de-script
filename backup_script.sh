#!/bin/bash

echo "Iniciando o backup em $(date)" >> ~/backup_log.txt

ORIGEM=~/Documentos2
DESTINO=~/Backup

# Cria o diretório de destino, caso não exista
mkdir -p $DESTINO

# Verifica se a pasta de origem tem arquivos
if [ -z "$(ls -A $ORIGEM)" ]; then
    echo "A pasta de origem está vazia. Nenhum arquivo para backup."
else
    # Copia os arquivos do diretório de origem para o de destino
    cp -r $ORIGEM/* $DESTINO
fi

# Cria um arquivo de backup compactado
tar -czf $DESTINO/backup_$(date +%F).tar.gz -C $DESTINO .

echo "Backup concluído em $(date)" >> ~/backup_log.txt
