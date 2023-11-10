# shadowCracker

** Segmentar el archivo **
* el maestro calcula la cantidad de trabajo por trabajador
* el maestro le asigna a cada trabajador el número de líneas a procesar (como parámetro de entrada)
* los trabajadores procesas las palabras en un for
* el maestro se queda esperando señales (una de éxito y otra de fracaso)
* Si el maestro recibe señal de éxito termina a los demás trabajadores (arreglo de pids de trabajadores)
