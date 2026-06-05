#!/bin/bash

read -p "Ingrese un nombre: " nombre
read -p "Ingrese edad: " edad

echo "Hola User: $nombre"
echo "Tu edad es: $edad"

echo "Dentro de 10 años tendrás: $((edad + 10)) años"
