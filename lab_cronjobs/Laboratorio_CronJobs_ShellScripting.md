# Laboratorio de Cron Jobs y Shell Scripting

## Entorno

-   Contenedor Ubuntu
-   Usuario: estudiante
-   Cron instalado
-   Directorio de trabajo: /home/estudiante

# Caso 1: Vigilancia de procesos críticos

## Objetivo

Verificar periódicamente si un proceso está activo.

## Contexto

Un administrador necesita validar que un proceso siga ejecutándose.

## Estructura

/home/estudiante/ ├── scripts/ └── monitor/

## Paso 1

mkdir -p \~/scripts mkdir -p \~/monitor

## Paso 2

nano \~/scripts/check_process.sh

``` bash
#!/bin/bash

PROCESS=sleep

if pgrep $PROCESS > /dev/null
then
    echo "$(date) - Proceso activo"
else
    echo "$(date) - Proceso detenido"
fi
```

## Paso 3

chmod +x \~/scripts/check_process.sh

## Paso 4

Ejecutar manualmente:

./scripts/check_process.sh

## Paso 5

Programar:

crontab -e

*/5 * \* \* \* /home/estudiante/scripts/check_process.sh

## Validación

Crear un proceso:

sleep 500

Ejecutar nuevamente.

## Reto

Cambiar el nombre del proceso a bash.

------------------------------------------------------------------------

# Caso 2: Limpieza automática de archivos temporales

## Objetivo

Eliminar archivos antiguos.

## Crear estructura

mkdir -p \~/temp

touch \~/temp/a.txt

## Script

nano \~/scripts/cleanup_temp.sh

``` bash
#!/bin/bash

find /home/estudiante/temp -type f -mtime +1 -delete
```

Permisos:

chmod +x \~/scripts/cleanup_temp.sh

Prueba manual.

Cron:

0 \* \* \* \* /home/estudiante/scripts/cleanup_temp.sh

Reto:

Eliminar archivos mayores a 10 minutos.

------------------------------------------------------------------------

# Caso 3: Monitor de conectividad

## Objetivo

Validar conectividad con un host.

Script:

nano \~/scripts/check_network.sh

``` bash
#!/bin/bash

HOST=8.8.8.8

ping -c 1 $HOST > /dev/null

if [ $? -eq 0 ]
then
    echo "Conexion correcta"
else
    echo "Sin conexion"
fi
```

Permisos:

chmod +x \~/scripts/check_network.sh

Prueba manual.

Cron:

*/5 * \* \* \* /home/estudiante/scripts/check_network.sh

Reto:

Validar dos hosts.

------------------------------------------------------------------------

# Caso 4: Supervisión de directorios

## Objetivo

Detectar cambios en un directorio.

Crear:

mkdir \~/entrada

Script:

nano \~/scripts/check_directory.sh

``` bash
#!/bin/bash

COUNT=$(find /home/estudiante/entrada -type f | wc -l)

echo "Archivos: $COUNT"
```

Permisos:

chmod +x \~/scripts/check_directory.sh

Crear archivos nuevos.

Cron:

*/5 * \* \* \* /home/estudiante/scripts/check_directory.sh

Reto:

Separar archivos txt y log.

------------------------------------------------------------------------

# Caso 5: Inventario del sistema

## Objetivo

Recolectar información básica del sistema.

Script:

nano \~/scripts/system_inventory.sh

``` bash
#!/bin/bash

echo "HOST:"
hostname

echo

echo "UPTIME:"
uptime

echo

echo "MEMORIA:"
free -h

echo

echo "DISCO:"
df -h

echo

echo "RED:"
ip addr
```

Permisos:

chmod +x \~/scripts/system_inventory.sh

Prueba manual.

Cron:

30 \* \* \* \* /home/estudiante/scripts/system_inventory.sh

Reto:

Agregar información del usuario actual usando whoami.

------------------------------------------------------------------------

# Buenas prácticas

1.  Ejecutar manualmente antes del Cron.
2.  Usar rutas absolutas.
3.  Dar permisos con chmod +x.
4.  Verificar Cron con crontab -l.
5.  Confirmar que el daemon esté activo:

sudo service cron start

ps aux \| grep cron

6.  Monitorear la salida de los scripts.
7.  Eliminar tareas de prueba cuando finalicen.

# Comandos útiles

crontab -e crontab -l crontab -r ps aux \| grep cron sudo service cron
start sudo service cron stop sudo service cron restart tail -f
archivo.txt chmod +x script.sh whoami pwd tree
