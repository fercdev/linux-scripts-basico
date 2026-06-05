# Laboratorio de Bash Scripting en Ubuntu 24.04 (Docker)

## Contexto del laboratorio

Contenedor basado en Ubuntu 24.04 con:

- Usuario: `estudiante`
- Home: `/home/estudiante`
- Shell: `bash`
- Herramientas: grep, awk, sed, jq, curl, git, python3, node, gcc, docker, htop, tree

---

# Preparación inicial

```bash
mkdir -p ~/laboratorio-scripting/{scripts,data,logs,backup}

cd ~/laboratorio-scripting

tree
```

Resultado esperado:

```text
.
├── backup
├── data
├── logs
└── scripts
```

---

# Laboratorio 1 - Variables y Entrada de Datos

## Objetivo

Capturar información ingresada por el usuario.

### Crear script

```bash
cd ~/laboratorio-scripting/scripts

nano usuario.sh
```

### Contenido

```bash
#!/bin/bash

echo "=== Registro de Usuario ==="

read -p "Nombre: " nombre
read -p "Edad: " edad

echo ""
echo "Resumen"
echo "Nombre: $nombre"
echo "Edad: $edad"
```

### Permisos

```bash
chmod +x usuario.sh
```

### Ejecutar

```bash
./usuario.sh
```

---

# Laboratorio 2 - Condicionales IF

## Objetivo

Validar si una persona es mayor o menor de edad.

```bash
nano validar_edad.sh
```

```bash
#!/bin/bash

read -p "Ingrese edad: " edad

if [ $edad -ge 18 ]
then
    echo "Mayor de edad"
else
    echo "Menor de edad"
fi
```

---

# Laboratorio 3 - Bucle FOR

## Objetivo

Crear directorios automáticamente.

```bash
nano crear_directorios.sh
```

```bash
#!/bin/bash

for i in {1..5}
do
    mkdir carpeta_$i
done
```

Ejecutar:

```bash
./crear_directorios.sh
```

Validar:

```bash
tree
```

---

# Laboratorio 4 - Bucle WHILE

## Objetivo

Simular procesamiento de registros.

```bash
nano contador.sh
```

```bash
#!/bin/bash

contador=1

while [ $contador -le 10 ]
do
    echo "Procesando registro $contador"
    contador=$((contador+1))
done
```

---

# Laboratorio 5 - Funciones

## Objetivo

Reutilizar bloques de código.

```bash
nano funciones.sh
```

```bash
#!/bin/bash

saludar() {
    echo "Hola $1"
}

despedir() {
    echo "Adios $1"
}

saludar Luis
despedir Luis
```

---

# Laboratorio 6 - CASE

## Objetivo

Implementar un menú simple.

```bash
nano menu.sh
```

```bash
#!/bin/bash

read -p "Accion: " accion

case $accion in

start)
    echo "Iniciando"
    ;;

stop)
    echo "Deteniendo"
    ;;

status)
    echo "Estado"
    ;;

*)
    echo "Opcion invalida"
    ;;

esac
```

---

# Laboratorio 7 - Dataset para grep, awk y sed

```bash
cd ~/laboratorio-scripting/data

nano empleados.csv
```

Contenido:

```csv
id,nombre,edad,departamento,salario
1,Luis,30,IT,5000
2,Ana,25,RRHH,3500
3,Pedro,40,IT,7000
4,Maria,28,Ventas,4000
5,Carlos,45,IT,8000
```

---

# Laboratorio 8 - grep

## Buscar registros IT

```bash
grep IT empleados.csv
```

## Buscar edad 25

```bash
grep 25 empleados.csv
```

## Contar coincidencias

```bash
grep IT empleados.csv | wc -l
```

---

# Laboratorio 9 - awk

## Mostrar nombres

```bash
awk -F',' '{print $2}' empleados.csv
```

## Mostrar nombre y salario

```bash
awk -F',' '{print $2,$5}' empleados.csv
```

## Salarios mayores a 5000

```bash
awk -F',' '$5 > 5000 {print $2,$5}' empleados.csv
```

---

# Laboratorio 10 - sed

## Reemplazo temporal

```bash
sed 's/IT/Tecnologia/g' empleados.csv
```

## Modificar archivo

```bash
sed -i 's/IT/Tecnologia/g' empleados.csv
```

Validar:

```bash
cat empleados.csv
```

---

# Laboratorio 11 - grep + awk

Obtener empleados del área de Tecnología.

```bash
grep Tecnologia empleados.csv \
| awk -F',' '{print $2}'
```

---

# Laboratorio 12 - Captura de comandos

```bash
nano sistema.sh
```

```bash
#!/bin/bash

fecha=$(date)
usuario=$(whoami)

echo "Fecha: $fecha"
echo "Usuario: $usuario"
```

---

# Laboratorio 13 - Logs

```bash
nano ~/laboratorio-scripting/logs/aplicacion.log
```

Contenido:

```text
INFO Inicio
INFO Login
ERROR Base de datos
INFO Logout
ERROR Conexion
```

Buscar errores:

```bash
grep ERROR ~/laboratorio-scripting/logs/aplicacion.log
```

Contarlos:

```bash
grep ERROR ~/laboratorio-scripting/logs/aplicacion.log | wc -l
```

---

# Laboratorio 14 - trap

## Objetivo

Capturar CTRL+C.

```bash
nano trap_demo.sh
```

```bash
#!/bin/bash

trap 'echo "CTRL+C detectado"; exit 1' SIGINT

while true
do
    echo "Trabajando..."
    sleep 2
done
```

Ejecutar:

```bash
./trap_demo.sh
```

Presionar:

```text
CTRL+C
```

---

# Laboratorio 15 - Script Integrador

```bash
nano reporte.sh
```

```bash
#!/bin/bash

archivo="../data/empleados.csv"

mostrar_total() {

    total=$(tail -n +2 $archivo | wc -l)

    echo "Total empleados: $total"
}

mostrar_it() {

    grep Tecnologia $archivo \
    | awk -F',' '{print $2}'
}

mostrar_total

echo ""

echo "Empleados IT"

mostrar_it
```

Salida esperada:

```text
Total empleados: 5

Empleados IT

Luis
Pedro
Carlos
```

---

# Temas dominados al finalizar

- Variables
- Entrada y salida estándar
- Parámetros
- Funciones
- IF / ELSE
- CASE
- FOR
- WHILE
- grep
- awk
- sed
- Pipes
- Captura de comandos $(...)
- Procesamiento de CSV
- Logs
- trap y señales
