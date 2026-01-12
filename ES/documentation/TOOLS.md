# Documentación de Herramientas Personalizadas

Guía para herramientas de seguridad personalizadas en The Sec Arena.

---

## 🛠️ Herramientas Disponibles

### Suite de Análisis de Logs

Ubicada en `tools/ALPHA/log_analysis/`

#### brute_force_checker.sh

**Propósito:** Detectar ataques de fuerza bruta SSH en el auth.log del sistema

**Uso:**
```bash
./brute_force_checker.sh /var/log/auth.log
```

**Salida:**
- Direcciones IP intentando fuerza bruta
- Conteos de intentos fallidos por IP
- Inicios de sesión exitosos desde fuentes de ataque
- Recomendación de Fail2ban

**Características:**
- Análisis de un solo paso (eficiente)
- Soporte para IPv4 e IPv6
- Detección basada en patrones
- Generación de línea de tiempo

**Limitaciones:**
- Solo analiza formato auth.log
- Requiere permisos adecuados de log
- Necesita datos de log recientes

---

#### log_analyzer.sh

**Propósito:** Extracción genérica de patrones y estadísticas de archivos de log

**Uso:**
```bash
# Contar ocurrencias
./log_analyzer.sh -C "ERROR" -f /var/log/syslog

# Obtener estadísticas
./log_analyzer.sh -s "http_status" -f access.log

# Extraer campo
./log_analyzer.sh -e 4 -f /var/log/auth.log
```

**Acciones:**
- `-C`: Contar coincidencias de patrón
- `-s`: Mostrar estadísticas (requiere campos numéricos)
- `-e`: Extraer campo (número de columna)
- `-c`: Obtener líneas de contexto alrededor de coincidencias
- `-u`: Mostrar solo valores únicos

**Ejemplos:**
```bash
# Códigos de estado HTTP principales
./log_analyzer.sh -e 9 -u -f access.log | head -10

# Contar intentos SSH fallidos
./log_analyzer.sh -C "Failed password" -f auth.log

# Extraer y contar IPs únicas
./log_analyzer.sh -e 1 -u -f access.log
```

**Rendimiento:**
- Diseño de lectura única
- Eficiente para logs grandes (1GB+)
- Huella de memoria mínima

---

## 🔧 Ciclo de Vida de Herramientas

### Etapa ALPHA
- Experimental, sin probar en producción
- Puede contener errores
- Usar para pruebas y retroalimentación
- Sin garantías de estabilidad

### Etapa BETA
- Probado y funcionando
- Problemas conocidos documentados
- Recopilando retroalimentación de usuarios
- Estabilidad mejorando

### Etapa RELEASE
- Listo para producción
- Estable y soportado
- Completamente documentado
- Mantenimiento regular

---

## 📈 Ruta de Desarrollo de Herramientas

Estado actual:
- **brute_force_checker.sh:** ALPHA → Listo para BETA (revisión de código completa)
- **log_analyzer.sh:** ALPHA → Listo para BETA (pruebas exhaustivas realizadas)

Próximos pasos para promoción a BETA:
1. Pruebas en logs de producción del mundo real
2. Recopilación de retroalimentación de usuarios
3. Manejo de casos extremos
4. Optimización de rendimiento

---

## 🔗 Documentación Relacionada

- [SETUP.md](SETUP.md) - Instrucciones de instalación
- [METHODOLOGY.md](METHODOLOGY.md) - Cuándo usar estas herramientas
- [RESOURCES.md](RESOURCES.md) - Referencias de análisis de logs

---

## 💬 Contribuyendo

¿Encontraste un error? ¿Tienes mejoras?

1. Prueba exhaustivamente y documenta el problema
2. Crea un reporte detallado de error
3. Envía pull request con la corrección
4. Sigue las guías de estilo de código

¡Todas las contribuciones son bienvenidas!
