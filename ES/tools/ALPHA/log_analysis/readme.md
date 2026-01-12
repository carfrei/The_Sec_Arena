# Suite de Análisis de Logs

Colección de herramientas de seguridad defensiva para analizar logs de sistemas y aplicaciones.

## Herramientas

### [Brute Force Checker](brute_force_checker/)

Detecta patrones de ataques de fuerza bruta SSH en auth.log.

- Identifica IPs sospechosas por intentos de inicio de sesión fallidos
- Marca inicios de sesión exitosos desde fuentes de ataque
- Genera línea de tiempo de ataque (primer/último intento)
- Reporta cuentas de usuario comprometidas

**Tecnología:** Script Bash usando grep, awk, sort

**Inicio rápido:**
```bash
cd brute_force_checker && chmod +x brute_force_checker.sh && sudo ./brute_force_checker.sh
```

### [Log Analyzer](log_analyzer/)

Herramienta genérica de extracción de patrones de logs y análisis para cualquier archivo de log.

- Buscar patrones en múltiples archivos de log
- Extraer campos específicos (IPs, usuarios, timestamps, comandos)
- Agregar y contar ocurrencias
- Generar estadísticas (primero/último/total)
- Identificar valores únicos

**Tecnología:** Script Bash con análisis de argumentos y extracción de campos

**Inicio rápido:**
```bash
cd log_analyzer && chmod +x log_analyzer.sh && ./log_analyzer.sh -f /var/log/syslog -p "error"
```

## Casos de Uso

- **Análisis post-compromiso** - Reconstrucción de línea de tiempo, recopilación de evidencia
- **Monitoreo de seguridad** - Detección de patrones, identificación de anomalías
- **Respuesta a incidentes** - Correlación de logs, análisis de causa raíz
- **Forensics** - Reconstrucción de eventos, línea de tiempo de actividad

## Requisitos

- Sistema Linux/Unix con bash
- Acceso de lectura a archivos de log (puede requerir sudo)
- Utilidades estándar: grep, awk, sed, sort, uniq

## Licencia

MIT
