#!/bin/bash

# VARIABLES
FECHA=$(date +"%Y%m%d_%H%M%S")

BACKUP_NAME="backup_${FECHA}.zip"

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/backup.log"

ORIGEN=$1
DESTINO=$2

BACKUP_FILE="$DESTINO/$BACKUP_NAME"

#setup
crear_log() {
    mkdir -p "$LOG_DIR"
}

registrar_log() {
    NIVEL=$1
    MENSAJE=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$NIVEL] $MENSAJE" >> "$LOG_FILE"
}

validar_parametros() {
    if [ $# -ne 2 ]
    then
        echo ""
        echo "Error: Número de parámetros incorrecto."
        echo "Uso: $0 <origen> <destino>"

        registrar_log ERROR "Error: Número de parámetros incorrecto. Uso: $0 <origen> <destino>"

        exit 2
    fi

    registrar_log INFO "PARAMETROS VALIDADOS CORRECTAMENTE"
}

validar_origen() {
    if [ ! -d "$ORIGEN" ]
    then
        echo ""
        echo "Error: Directorio de origen inexistente."

        registrar_log ERROR "Error: origen inexistente: $ORIGEN"

        exit 3
    fi

    registrar_log INFO "ORIGEN VALIDADO CORRECTAMENTE"
}

validar_destino() {
    if [ ! -d "$DESTINO" ]
    then
        echo ""
        registrar_log WARN "Destino inexistente: $DESTINO"
        echo "Creando directorio destino: $DESTINO"
        mkdir -p "$DESTINO"
        registrar_log INFO "Destino creado: $DESTINO"
    else 
        registrar_log INFO "Destino validado correctamente: $DESTINO"
    fi
}

verificar_espacio() {
    ESPACIO_REQUERIDO=$(du -sb "$ORIGEN" | awk '{print $1}')
    ESPACIO_DISPONIBLE=$(df -B1 "$DESTINO" | tail -1 | awk '{print $4}')

    registrar_log INFO "Espacio requerido: $ESPACIO_REQUERIDO"
    registrar_log INFO "Espacio disponible: $ESPACIO_DISPONIBLE"

    if [ "$ESPACIO_DISPONIBLE" -lt "$ESPACIO_REQUERIDO" ]
    then
        echo ""
        echo "ERROR: Espacio insuficiente"

        registrar_log ERROR "Espacio insuficiente"

        exit 4
    fi
    
    registrar_log INFO "Espacio suficiente para el Backup"
}

crear_backup_zip() {
    registrar_log INFO "Iniciando compresion"

    zip -r "$BACKUP_FILE" "$ORIGEN" > /dev/null
}

verficar_backup() {

    if [ -f "$BACKUP_FILE" ]
    then
        echo ""
        echo "Backup generado correctamente"
        echo "$BACKUP_FILE"

        registrar_log INFO "Backup generado correctamente"

        exit 0

    else 
        echo ""
        echo "ERROR: Backup no generado"

        registrar_log ERROR "Error generando backup"

        exit 5
    fi
}

## MAIN DE BACKUP

crear_log

registrar_log INFO "Inicio del backup"

validar_parametros "$@"

validar_origen

validar_destino

verificar_espacio

crear_backup_zip

verficar_backup