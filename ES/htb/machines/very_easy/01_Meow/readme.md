# Máquina HackTheBox: Meow
**Desafío Introductorio de Telnet**

## Vista General de la Máquina
Máquina HTB fundamental que enseña conceptos básicos de redes y acceso telnet. Introducción a máquinas virtuales, conectividad VPN y herramientas de reconocimiento por línea de comandos.

**Dificultad:** Very Easy | **Estado:** Retirada | **Plataforma:** HackTheBox Machines | **Tipo:** Tutorial/Starting Point

---

## Metodología

### Fase 1: Configuración y Conectividad
- Configurar entorno de Máquina Virtual
- Establecer conexión VPN vía OpenVPN
- Verificar conectividad al objetivo con ping ICMP

### Fase 2: Reconocimiento
- Escaneo de puertos con Nmap para identificar servicios abiertos
- Enumeración de servicios en puertos descubiertos
- Identificar servicio telnet en puerto por defecto 23/tcp

### Fase 3: Explotación
- Conectar al servicio telnet sin credenciales
- Identificar autenticación débil (contraseña en blanco)
- Recuperar acceso root

### Fase 4: Extracción de Flag
- Acceder a shell root
- Localizar y capturar flags de prueba

---

## Tareas y Respuestas

### ✅ Tarea 1: Definición de Máquina Virtual
**P:** ¿Qué significa el acrónimo VM?  
**R:** `Virtual Machine`

**Explicación:** Una Máquina Virtual es una emulación por software de un sistema informático que ejecuta un sistema operativo y aplicaciones, proporcionando entornos aislados para pruebas y aprendizaje.

---

### ✅ Tarea 2: Interfaz de Línea de Comandos
**P:** ¿Qué herramienta usamos para interactuar con el sistema operativo para emitir comandos vía línea de comandos?  
**R:** `terminal`

**Explicación:** También conocida como consola o shell, la terminal proporciona acceso de interfaz de línea de comandos (CLI) para emitir comandos del sistema, incluyendo inicio de conexión VPN.

---

### ✅ Tarea 3: Servicio VPN
**P:** ¿Qué servicio usamos para formar nuestra conexión VPN a los labs HTB?  
**R:** `openvpn`

**Explicación:** OpenVPN es el servicio VPN usado para establecer conexiones cifradas a entornos de laboratorio HackTheBox, habilitando acceso seguro a máquinas objetivo.

---

### ✅ Tarea 4: Pruebas de Conectividad
**P:** ¿Qué herramienta usamos para probar nuestra conexión al objetivo con una solicitud de eco ICMP?  
**R:** `ping`

**Explicación:** La utilidad Ping envía solicitudes de eco ICMP para verificar conectividad de red y medir latencia a sistemas objetivo.

**Comando:**
```bash
ping <target-ip>
```

---

### ✅ Tarea 5: Herramienta de Escaneo de Puertos
**P:** ¿Cuál es el nombre de la herramienta más común para encontrar puertos abiertos en un objetivo?  
**R:** `nmap`

**Explicación:** Nmap (Network Mapper) es la herramienta estándar de la industria para reconocimiento de red, escaneo de puertos y enumeración de servicios.

**Comando:**
```bash
nmap -p- <target-ip>  # Escanear todos los puertos
nmap -sV <target-ip>  # Identificar servicios
```

---

### ✅ Tarea 6: Identificación de Servicio
**P:** ¿Qué servicio identificamos en el puerto 23/tcp durante nuestros escaneos?  
**R:** `telnet`

**Explicación:** El puerto 23/tcp ejecuta el servicio Telnet, un protocolo de inicio de sesión remoto sin cifrar. El escaneo Nmap revela este servicio en el objetivo.

**Salida de Nmap:**
```
23/tcp open telnet
```

---

### ✅ Tarea 7: Autenticación
**P:** ¿Qué nombre de usuario es capaz de iniciar sesión en el objetivo por telnet con una contraseña en blanco?  
**R:** `root`

**Explicación:** La máquina Meow demuestra prácticas de seguridad débiles al permitir inicio de sesión root sin autenticación de contraseña, resaltando la importancia de controles de acceso apropiados.

**Conexión Telnet:**
```bash
telnet <target-ip>
# Cuando se solicite nombre de usuario, ingresar: root
# Cuando se solicite contraseña, presionar Enter (contraseña en blanco)
# Sesión iniciada exitosamente como root
```

---

## Hallazgos Clave

| Categoría | Detalle |
|----------|--------|
| **Vulnerabilidad** | Servicio telnet sin cifrar con autenticación débil |
| **Causa Raíz** | Contraseña root en blanco; sin aplicación de autenticación |
| **Vector de Ataque** | Inicio de sesión telnet sin credenciales |
| **Impacto** | Compromiso completo del sistema y ejecución remota de código |
| **Lección** | Nunca usar telnet en producción; deshabilitar inicio de sesión root remoto; aplicar autenticación fuerte |

---

## Resumen de Reconocimiento

```bash
# Paso 1: Verificar conectividad
ping <target-ip>

# Paso 2: Escanear puertos abiertos
nmap <target-ip>

# Paso 3: Conectar a telnet
telnet <target-ip>

# Paso 4: Iniciar sesión con root/contraseña en blanco
root
[contraseña en blanco - solo presionar Enter]

# Paso 5: Capturar flag
cat flag.txt
```

---

## Herramientas Usadas
- **Virtual Machine** - Entorno de laboratorio
- **Terminal/Console** - Interfaz de línea de comandos
- **OpenVPN** - Conectividad VPN
- **ping** - Verificación de conectividad ICMP
- **nmap** - Escaneo de puertos y servicios
- **telnet** - Cliente de inicio de sesión remoto

---

## Objetivos de Aprendizaje Logrados
✅ Entender conceptos de máquina virtual
✅ Configurar conectividad VPN
✅ Usar ping para pruebas de conectividad
✅ Realizar reconocimiento de red con nmap
✅ Identificar servicios en ejecución en sistemas objetivo
✅ Conectar vía protocolo telnet
✅ Reconocer prácticas de autenticación débil

---

## Implicaciones de Seguridad

Esta máquina demuestra fallas de seguridad críticas:
- **Protocolo Sin Cifrar:** Telnet transmite credenciales en texto plano
- **Autenticación Débil:** Contraseña en blanco para cuenta privilegiada
- **Sin Controles de Acceso:** Login root permitido remotamente
- **Servicio Obsoleto:** Telnet nunca debe usarse en producción

**Alternativas Modernas:**
- SSH con autenticación basada en claves
- Reglas de firewall apropiadas
- Políticas de autenticación fuertes

---

## Puntuación
**100% Completo** ✓
Todas las tareas respondidas y máquina explotada exitosamente.

---

**Fecha de Finalización:** 26 de diciembre de 2025  
**Dificultad de Máquina:** Very Easy ⭐  
**Tiempo para Completar:** < 30 minutos  
**Estado:** Retirada (Recurso de Aprendizaje)
