#!/bin/bash

# Diretório de origem e destino
SOURCE_DIR="/home/philipe/documentos"
RSYNC_BACKUP_DIR="/home/philipe/backups"
BORG_BACKUP_DIR="/home/philipe/borg-backups"

# Função para fazer backup com rsync
backup_rsync() {
    echo "Iniciando backup com rsync..."
    rsync -av --progress "$SOURCE_DIR/" "$RSYNC_BACKUP_DIR/"
    echo "Backup com rsync concluído!"
}

# Função para fazer backup com Borg
backup_borg() {
    echo "Iniciando backup com BorgBackup..."
    # Inicializa o repositório, se ele não existir
    if [ ! -d "$BORG_BACKUP_DIR" ]; then
        mkdir -p "$BORG_BACKUP_DIR"
        borg init --encryption=repokey "$BORG_BACKUP_DIR"
    fi
    # Cria o backup com um nome de arquivo baseado na data e hora
    borg create --progress "$BORG_BACKUP_DIR::backup-$(date +%Y-%m-%d-%H%M)" "$SOURCE_DIR"
    echo "Backup com Borg concluído!"
}

# Verifica o tipo de backup a ser executado
if [ "$1" == "rsync" ]; then
    backup_rsync
elif [ "$1" == "borg" ]; then
    backup_borg
else
    echo "Por favor, especifique o tipo de backup: rsync ou borg."
    exit 1
fi
