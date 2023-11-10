#!/bin/bash

#lineas="$1"
diccionario="$2"
salt="$4"
algoritmo="$5"
check_hash() {
	while read -r linea; do
		sudo openssl passwd -"$algoritmo" -salt "$salt" "$linea"
	done < "$archivo"
	
}

echo "Hola soy trabajador"
