#!/bin/bash

CONTADOR=1

# viene de la palabra "hasta" que llegue a 10
until [ $CONTADOR -gt 10 ]; do
    echo "Contador: $CONTADOR"
    CONTADOR=$((CONTADOR + 1))
done