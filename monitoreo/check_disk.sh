#!/bin/bash

source /home/estudiante/monitoreo/config/settings.conf

CURRENT_DATE=$(date)

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "$CURRENT_DATE - USO DE DISCO: ${DISK_USAGE}%" >> /home/estudiante/monitoreo/logs/disk.log

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "$CURRENT_DATE - ALERTA: Disco al ${DISK_USAGE}%" >> /home/estudiante/monitoreo/logs/alerts.log
fi