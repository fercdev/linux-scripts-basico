#!/bin/bash

if [ ! -f "archivo_data.txt" ]
then
    echo "No existe"
    exit 1
fi

echo "Archivo encontrado"
exit 0