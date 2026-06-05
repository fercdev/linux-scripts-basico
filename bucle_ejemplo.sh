#!/bin/bash

# bucle basico
echo "Bucle basico"

for numero in 1 2 3 4 5
do
    echo "El numero es: $numero"
done

# bucle en lista de array
echo "Bucle en lista de array"

for numero in {1..10}
do
    echo "El numero es:: $numero"
done

echo "Bucle para crear directorios"

for numero in {1..3}
do
    mkdir carpeta_$numero
done

echo "Bucle para listar archivos"

for archivo in *
do
    echo $archivo
done