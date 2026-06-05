#!/bin/bash

#variable de edad
edad=17
nombre="Pedro"

if [ $edad -ge 18 ] # ge -> mayor o igual que
then
    echo "Eres mayor de edad"
else
    echo "Eres menor de edad"
fi

# Operadores de comparación:
# -eq: igual a
# -ne: diferente de
# -gt: mayor que
# -lt: menor que
# -le: menor o igual que
# -ge: mayor o igual que


# Operador de compracion de cadena de texto:

# ==: igual a
# !=: diferente de
# < : menor que (en orden lexicográfico)
# > : mayor que (en orden lexicográfico)


if [ "$nombre" == "Juan" ]
then
    echo "Hola Juan"
else
    echo "No eres Juan"
fi

# Operadores logicos:

# &&: AND lógico
# ||: OR lógico
# !: NOT lógico

if [ $edad -ge 18 ] && [ "$nombre" == "Pedro" ]
then
    echo "Eres Pedro y eres mayor de edad"
else
    echo "No eres Pedro o no eres mayor de edad"
fi

# -- caso de OR
if [ $edad -ge 18 ] || [ "$nombre" == "Pedro" ]
then
    echo "Eres Pedro o eres mayor de edad"
else
    echo "No eres Pedro y no eres mayor de edad"
fi