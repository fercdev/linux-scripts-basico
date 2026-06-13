# Laboratorio de Cron Jobs - Casos Reales

## Requisitos

Este laboratorio fue diseñado para ejecutarse sobre:

- Ubuntu Container
- Usuario: estudiante
- Cron instalado
- Servicio cron iniciado

Verificar:

```bash
whoami

sudo service cron start

ps aux | grep cron
```

Salida esperada:

```
estudiante

root ... /usr/sbin/cron
```

---

# LAB 02 - Dos Cron Jobs accediendo al mismo recurso

## Objetivo

Comprender qué sucede cuando dos Cron Jobs utilizan el mismo archivo.

## Escenario

Dos scripts escribirán sobre el mismo archivo.

## Paso 1

Crear carpeta:

```bash
mkdir ~/cronlab

cd ~/cronlab
```

---

## Paso 2

Crear Script A

```bash
nano scriptA.sh
```

```bash
#!/bin/bash

echo "$(date) - SCRIPT A INICIO" >> resultado.txt

sleep 20

echo "$(date) - SCRIPT A FIN" >> resultado.txt
```

Permisos:

```bash
chmod +x scriptA.sh
```

---

## Paso 3

Crear Script B

```bash
nano scriptB.sh
```

```bash
#!/bin/bash

echo "$(date) - SCRIPT B INICIO" >> resultado.txt

sleep 20

echo "$(date) - SCRIPT B FIN" >> resultado.txt
```

Permisos:

```bash
chmod +x scriptB.sh
```

---

## Paso 4

Agregar Cron

```
* * * * * /home/estudiante/cronlab/scriptA.sh

* * * * * /home/estudiante/cronlab/scriptB.sh
```

---

## Paso 5

Esperar un minuto.

Ver:

```bash
cat resultado.txt
```

Posible salida:

```
SCRIPT A INICIO

SCRIPT B INICIO

SCRIPT A FIN

SCRIPT B FIN
```

O

```
SCRIPT B INICIO

SCRIPT A INICIO

SCRIPT B FIN

SCRIPT A FIN
```

## Aprendizaje

Dos Cron Jobs pueden acceder al mismo recurso.

---

# LAB 03 - Script más lento que el Cron

## Objetivo

Ver qué ocurre cuando un script demora más que su frecuencia.

## Paso 1

Crear:

```bash
nano slow.sh
```

```bash
#!/bin/bash

echo Inicio

sleep 400

echo Fin
```

Permisos:

```bash
chmod +x slow.sh
```

---

## Paso 2

Agregar Cron

```
*/5 * * * * /home/estudiante/cronlab/slow.sh
```

---

## Paso 3

Esperar algunos minutos.

Ver:

```bash
ps aux | grep sleep
```

Posible salida:

```
sleep 400

sleep 400
```

## Aprendizaje

Varias ejecuciones pueden quedar activas.

---

# LAB 04 - El recurso desaparece

## Objetivo

Observar qué sucede cuando un script depende de un recurso inexistente.

## Paso 1

Crear:

```bash
mkdir destino

touch archivo.txt
```

---

## Paso 2

Crear script

```bash
#!/bin/bash

mv archivo.txt destino/
```

---

## Paso 3

Ejecutar manualmente.

Debe funcionar.

---

## Paso 4

Eliminar:

```bash
rm -r destino
```

---

## Paso 5

Ejecutar nuevamente.

Posible salida:

```
mv: cannot move ...

No such file or directory
```

## Aprendizaje

Siempre validar recursos antes de operar.

---

# LAB 05 - Monitoreo de procesos

## Objetivo

Detectar procesos activos.

## Paso 1

Crear proceso:

```bash
sleep 500 &
```

Ver PID:

```bash
pgrep sleep
```

Salida:

```
1234
```

---

## Paso 2

Crear script

```bash
#!/bin/bash

pgrep sleep
```

---

## Paso 3

Agregar Cron

```
* * * * * script.sh
```

---

## Paso 4

Eliminar proceso.

```bash
kill PID
```

---

## Paso 5

Crear varios procesos.

```bash
sleep 300 &

sleep 400 &

sleep 500 &
```

Ver:

```bash
pgrep sleep
```

Posible salida:

```
1010

1020

1030
```

## Aprendizaje

Un mismo proceso puede tener múltiples instancias.

---

# Comandos útiles

Ver Cron:

```bash
crontab -l
```

Editar:

```bash
crontab -e
```

Eliminar:

```bash
crontab -r
```

Iniciar Cron:

```bash
sudo service cron start
```

Ver Cron:

```bash
ps aux | grep cron
```

Ver procesos:

```bash
ps aux

pgrep

top

htop
```

Ver archivos:

```bash
cat

tail -f

ls

tree
```