#!/bin/bash
ayuda() {
	cat << EOF
script que intenta crackear la contraseña de un usuario en el archivo /etc/shadow
Utiliza multiprocesos que ejecutan el comando openssl para verificar los hashes de las contraseñas
Uso:
	shadowCracker.sh archivo usuario diccionario procesadores
		Archivo: Es la ruta del archivo /etc/shadow desde el que se obtendra el hash del usuario.
		Usuario: Usuario que se encuentra dentro del archivo /etc/shadow y del cuál se busca crackear la contraseña.
		Diccionario: Ruta del diccionario de palabras con el que se intentara crackear la contraseña.
		Procesadores: Cantidad de procesadores que se utilizaran.		
EOF
}

procesar_respuesta() {
    echo "ya me contestó el trabajador"
    exit 0
}

main() {
	local archivo="$1"
	local usuario="$2"
	local diccionario="$3"
	local procesadores="$4"
	
	local numLineasDic=$(cat "$diccionario" | wc -l)
	local divisionTrabajo
	let divisionTrabajo=$numLineasDic/$procesadores
	echo $divisionTrabajo

	local algoritmo=$(cat "$archivo" | grep -Po "^$usuario:.\K.")
	local salt=$(cat "$archivo" | grep -Po "^$usuario:...\K([A-z0-9].)+")
	echo $algoritmo
	echo $salt
	local hash=$(cat "$archivo" | grep -Po "^$usuario:...([A-z0-9].)+.\K([A-z0-9])+")	
	echo $hash
	ruta_ejecucion="${0%/*}"
	"$ruta_ejecucion"/worker.sh &
	
}
archivo="$1"
usuario="$2"
diccionario="$3"
procesadores="$4"


#test -f "$archivo" || { echo "El primer parámetro debe de ser un archivo" ; ayuda ; exit 1 ; }
#test "$usuario" || { echo "El segundo parámetro no puede estar vació" ; ayuda ; exit 1 ; }
#test -f "$diccionario" || { echo "El tercer parámetro debe de ser un archivo" ; ayuda ; exit 1 ; }
#test "$procesadores" || { echo "El cuarto parámetro no puede estar vació" ; ayuda ; exit 1 ; }



main "$archivo" "$usuario" "$diccionario" "$procesadores"

#pid_trabajador=$!
#pid_padre=$(ps -ef | grep -Po "^[^ ]+ +$$ +\K[^ ]+")
