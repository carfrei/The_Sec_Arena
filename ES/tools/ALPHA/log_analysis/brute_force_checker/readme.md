# Brute Force Checker

Herramienta de seguridad defensiva para analizar logs de autenticación SSH y detectar patrones de ataques de fuerza bruta.

## Propósito

Identifica y reporta intentos de acceso no autorizado en `auth.log`:
- IPs de origen con altos intentos de inicio de sesión fallidos
- Inicios de sesión exitosos desde IPs sospechosas
- Línea de tiempo de ataque (primer/último intento)
- Cuentas de usuario comprometidas
- Recomendaciones para hardening

## Uso

```bash
./brute_force_checker.sh [archivo_log] [umbral]
```

### Argumentos

| Argumento | Por Defecto | Descripción |
|----------|---------|-------------|
| `archivo_log` | `/var/log/auth.log` | Ruta al log de autenticación SSH |
| `umbral` | `10` | Intentos fallidos para marcar como sospechoso |

### Ayuda

```bash
./brute_force_checker.sh -h
```

### Ejemplos

```bash
# Por defecto (auth.log del sistema, umbral=10)
sudo ./brute_force_checker.sh

# Archivo de log personalizado
sudo ./brute_force_checker.sh /var/log/auth.log.1 15

# Umbral específico
sudo ./brute_force_checker.sh /tmp/test.log 5
```

## Secciones de Salida

1. **Intentos de inicio de sesión fallidos por IP** - Cuenta intentos fallidos por IP de origen, marca como `[SUSPICIOUS]` si >= umbral

2. **Inicios de sesión exitosos desde IPs principales** - Lista IPs con autenticación exitosa y cuentas de usuario comprometidas

3. **Línea de tiempo de ataque** - Primer intento, último intento y conteo total por IP sospechosa

4. **Resumen de inicios de sesión exitosos** - Total de inicios de sesión exitosos y principales cuentas de usuario

5. **Recomendaciones** - Pasos de hardening (fail2ban, autenticación por clave SSH, deshabilitar login root, etc.)

## Ejemplo de Salida

```
=== Reporte de Detección de Fuerza Bruta ===
Log: /var/log/auth.log | Umbral: 10 intentos | Fecha: Wed Jan 12 10:30:22 UTC 2026

[*] Intentos de inicio de sesión fallidos por IP:
  45 203.0.113.10 [SUSPICIOUS]
  23 198.51.100.5 [SUSPICIOUS]
  8 192.0.2.100

[*] Inicios de sesión exitosos desde IPs principales:
  203.0.113.10: 3 logins (usuarios: root, ubuntu)

[*] Línea de tiempo de ataque (primer/último intento):
  203.0.113.10: primero=Dec 23 14:32:01 | último=Dec 25 09:15:47 | total=45

[*] Resumen de inicios de sesión exitosos:
  Total de inicios de sesión exitosos: 142
  Usuarios principales:
    ubuntu: 87 logins
    admin: 32 logins
    root: 23 logins
```

## Requisitos

- Sistema Linux/Unix con bash
- Acceso de lectura al archivo de log (usar `sudo` para `/var/log/auth.log`)
- Utilidades estándar: grep, awk, sort, uniq

### Configuración

Asegúrate de que el script tiene permisos de ejecución:
```bash
chmod +x brute_force_checker.sh
```

## Cómo Funciona

### Detección de IP

Extrae IPs de origen de entradas de contraseña fallida:
```bash
grep "Failed password" | grep -oP '(?<=from )\S+' | sort | uniq -c | sort -rn
```

### Detección de Brechas Exitosas

Para cada IP sospechosa, verifica inicios de sesión exitosos:
```bash
grep "Accepted password" | grep "from $ip" | grep -oP '(?<=for )\S+'
```

### Análisis de Línea de Tiempo

Extrae timestamps del primer y último intento para análisis de patrones.

## Legal y Ético

**USO DEFENSIVO ÚNICAMENTE**

Esta herramienta está diseñada para:
- ✅ Investigación de incidentes en sistemas que posees/administras
- ✅ Monitoreo y hardening de seguridad
- ✅ Análisis post-compromiso
- ✅ Análisis de logs en pruebas de penetración autorizadas

**NO para:**
- ❌ Acceso no autorizado a sistemas
- ❌ Ataques ofensivos
- ❌ Violación de políticas de acceso a sistemas

## Limitaciones

- Solo analiza intentos exitosos/fallidos en auth.log (no actividad del sistema)
- No puede detectar ataques usando credenciales válidas desde IPs legítimas
- Requiere que los logs se retengan en disco (la rotación de logs puede eliminar evidencia)
- No puede identificar ataques usando claves SSH (solo intentos basados en contraseña)

## Recomendaciones

Si esta herramienta detecta actividad sospechosa:

1. **Inmediato:**
   - Revisar fuentes de inicio de sesión exitosas y cuentas de usuario
   - Verificar uso no autorizado de sudo: `grep "sudo" /var/log/auth.log`
   - Verificar procesos en ejecución: `ps aux | grep -v grep`

2. **Corto plazo:**
   - Implementar `fail2ban` para bloqueo automático de IP
   - Deshabilitar autenticación por contraseña (usar solo claves SSH)
   - Deshabilitar login root: `PermitRootLogin no` en `/etc/ssh/sshd_config`

3. **Largo plazo:**
   - Monitorear logs con logging centralizado (ELK, Splunk)
   - Implementar MFA para todas las cuentas
   - Rotar claves SSH trimestralmente
   - Auditorías de seguridad regulares

## Limitaciones

**Casos extremos importantes y limitaciones conocidas:**

- **Asunción de formato de log**: Asume formato estándar sshd auth.log. Formatos de log personalizados pueden no analizarse correctamente
- **Regex de IP**: Patrón `(?<=from )\S+` asume IP/hostname inmediatamente después de "from ". Logs malformados pueden extraer datos parciales
- **Conciencia de zona horaria**: Timestamps extraídos son tiempo local del log. Sin conversión UTC
- **Rendimiento con archivos grandes**: El script carga el log completo en memoria vía asignación de variable. Archivos >100MB pueden ser lentos
- **Detección parcial de compromiso**: Solo detecta inicios de sesión exitosos REGISTRADOS en auth.log. No detecta:
  - Ataques basados en clave SSH (sin intentos fallidos registrados)
  - Escaneo de puertos en otros puertos
  - Ataques vía otros servicios (FTP, HTTP, etc)
  - Rootkits o persistencia a nivel kernel
- **Extracción de campo de usuario**: Asume formato estándar `for <username>`. Módulos PAM personalizados pueden romper esto
- **Retención de datos**: Solo analiza el archivo de log actual. Logs rotados requieren análisis separado
- **Falsos positivos**: Usuarios legítimos con intentos fallidos (errores de tipeo, problemas de clave) pueden aparecer sospechosos
- **Falsos negativos**: Atacantes con tasas de solicitud bajas pueden no activar el umbral

## Flujo de Trabajo Recomendado

1. Ejecutar regularmente (cron job): `0 */6 * * * /ruta/a/brute_force_checker.sh`
2. Analizar salida solo para entradas [BREACH] en respuestas automatizadas
3. Siempre verificar manualmente los hallazgos antes de tomar acción
4. Combinar con otro monitoreo (netstat, monitoreo de procesos, integridad de archivos)
5. Archivar reportes para cumplimiento y forensics

## Autor

DrCarfrei

## Licencia

MIT
