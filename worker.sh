#!/bin/bash
diccionario="$1"
salt="$2"
algoritmo="$3"
hash_pass="$4"

pid=$(ps -o ppid= -p $$)
check_hash() {
	while read -r linea ; do
		hash_test=$(openssl passwd -"$algoritmo" -salt "$salt" "$linea")
		if [ "$hash_test" == "$hash_pass" ]; then
			echo "La contraseña es: $linea"
			kill -s USR1 "$pid"
		fi
	done < "$diccionario"
	
}

check_hash "$diccionario" "$salt" "$algoritmo" "$hash_pass"
