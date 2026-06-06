#!/bin/bash

# VARIABLES

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/backup.log"

ORIGEN=$1
DESTINO=$2

#setup
crear_log() {
    mkdir -p "$LOG_DIR"
}

registrar_log() {
    MENSAJE=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $MENSAJE" >> "$LOG_FILE"
}

validar_parametros() {
    if [ $# -ne 2 ]
    then
        echo ""
        echo "Error: Número de parámetros incorrecto."
        echo "Uso: $0 <origen> <destino>"

        registrar_log "Error: Número de parámetros incorrecto. Uso: $0 <origen> <destino>"

        exit 2
    fi
}

validar_origen() {
    if [ ! -d "$ORIGEN" ]
    then
        echo ""
        echo "Error: Directorio de origen inexistente."

        registrar_log "Error: origen inexistente: $ORIGEN"

        exit 3
    fi
}

validar_destino() {
    if [ ! -d "$DESTINO" ]
    then
        echo ""
        echo "ALERTA: Directorio destino inexistente."
        echo "Creando directorio destino: $DESTINO"
        mkdir -p "$DESTINO"
        registrar_log "Creando directorio destino: $DESTINO"
    fi
}

crear_backup() {
    cp -r "$ORIGEN" "$DESTINO"
}

verificar_backup() {
    NOMBRE=$(basename "$ORIGEN")

    if [ -d "$DESTINO/$NOMBRE" ]
    then
        echo ""
        echo "Backup creado exitosamente en: $DESTINO/$NOMBRE"
        registrar_log "Backup creado exitosamente en: $DESTINO/$NOMBRE"

        exit 0
    else
        echo ""
        echo "Error: Backup no se creó correctamente."
        registrar_log "Error: Backup no se creó correctamente."
        exit 4
    fi
}

## MAIN DE BACKUP


crear_log

registrar_log "Inicio del backup"

validar_parametros "$@"

validar_origen

validar_destino

crear_backup

verificar_backup