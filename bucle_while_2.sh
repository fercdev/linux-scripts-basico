#!/bin/bash

continuar="si"

while [ $continuar = "si" ]; do
    echo "Procesando..."
    
    read -p "¿Deseas continuar? (si/no): " continuar
done