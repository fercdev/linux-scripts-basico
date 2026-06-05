#!/bin/bash

case $1 in
    "start")
        echo "Iniciando proceso"
        ;;
    "stop")
        echo "Deteniendo proceso"
        ;;
    *)
        echo "Opción no reconocida. Por favor, ingresa 'start' o 'stop'."
        ;;
esac