En este documento ire comentando todo lo que vaya haciendo y aprendiendo en los niveles mencionados.

**Nivel 0 **
Se menciona que debo conectarme mediante ssh al host bandit.labs.overthewire.org usando el puerto 2220
Se me menciona adicionalmente que mis datos de ingreso son:
username: **bandit0**
password: **bandit0**

proceso a hacer el ingreso usando el siguiente comando:
**ssh bandit0@bandit.labs.overthewire.org -p 2220**

lo que me da el ingreso,
                         _                     _ _ _   
                        | |__   __ _ _ __   __| (_) |_ 
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_ 
                        |_.__/ \__,_|_| |_|\__,_|_|\__|

ya en el servidor, procedo a listar que existe en la raiz mediante el comando:
**ls**
encuentro un archivo readme
procedo a ver que tiene su contenido mediante el comando:
**cat**

reviso el siguiente mensaje:

**Congratulations on your first steps into the bandit game!!**

The password you are looking for is: ****************

con eso puedo seguir oficialmente al nivel 1

**nivel 1**
usando el siguiente comando:
**ssh bandit1@bandit.labs.overthewire.org -p 2220**

me eh logeado para el reto del nivel
al usar el comando **ls** me doy cuenta que se muestra solo **-** por lo cual para leerlo debo ser especifico, asi que lo nombre de la siguiente manera para ver su contenido:
**cat ./-** asi puedo ver la contrasena de este nivel.

**nivel 2**

luego de ingresar al nivel y usar el comando **ls** me doy cuenta que el archivo se llama
--spaces in this filename--
intento usar cat "spaces in this file name" pero me da error.
intento usar cat ./"spaces in this file name" me da error
intento usar cat como comando global para evitar errores de la siguiente manera:
**cat ./"--spaces in this filename--"** Loteria
eh conseguido la clave para el siguiente nivel.

**nivel 3**

Despues de ingresar y listar las carpetas del directorio puedo observar que la unica carpeta existente se llama **inhere**
la instruccion de este nivel menciona que debo buscar carpetas ocultas asi que realizo cd inhere y al ingresa listo ls -la
encuentro un documento llamado ...Hiding-From-You
siguiendo la logica del nivel anterior mi comando debe ser
**cat ./"...Hiding-From-You**
Loteria, eh conseguido la llave del nivel 4

**Nivel 4**

Al igual que el nivel anterior, use comandos similares
al ingresar vi que existe el mismo dir llamado inhere.
al ingresar y usar ls pude ver que existen archivos -file## listados del 00 al 09, buscando manualmente de 1 en 1 mediante el comando cat ./"filename" descubri que el pass estaba en el archivo 07, intuyo que debe haber una forma mas rapida de buscar, actualizare segun hallasgos proximamente.
luego de abrir el archivo 07 encontre el pass para el siguiente nivel.

**nivel 5**

en este ejercicio pude ver que existen varias carpetas y subcarpetas, la pista que nos entregan es el hecho de que :

    human-readable
    1033 bytes in size
    not executable

entonces eh aprendido a usar el siguiente comando:
**find . -type f -size 1033c ! -executable**
de esta manera eh podido encontrar el lugar adecuado sin buscar por todos lados de uno en uno
./maybehere07/.file2
mediante el comando **cat ./"maybehere07"/.file2**
eh encontrado el pass para el siguiente nivel.

**nivel 6**
