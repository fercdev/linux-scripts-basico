#!/bin/bash

ls archivo_inexistente.txt #forzando un error porque el archivo no existe

echo $? # cero para cuando el comando es correcto y 1 o distinto a cero cuando es error