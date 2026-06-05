#!/bin/bash


saludar() {
    echo "Hola Mundo"
}

saludarNombre() {
    echo "Hola: $1"
}

mostrar_parametros() {
    echo "Nombre: $1"
    echo "Edad: $2"
}

saludar

saludarNombre "Alfredo"

mostrar_parametros "Marcos" 30