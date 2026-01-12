# ALPHA - Experimental y Desarrollo

Las herramientas en esta etapa son **funcionales pero no probadas en entornos de producción**. Usar únicamente para aprendizaje, pruebas y retroalimentación.

## Criterios de Estado

**Herramientas ALPHA:**
- ✅ Código completo y funcional
- ✅ Documentación presente
- ✅ Limitaciones conocidas documentadas
- ❌ NO probado en OS objetivo (Parrot OS 6.4)
- ❌ NO usado en escenarios reales
- ❌ Sin retroalimentación de usuarios
- ❌ Posibles errores o casos extremos

## Herramientas

### [Suite de Análisis de Logs](log_analysis/)

Herramientas defensivas para detección de fuerza bruta SSH y análisis genérico de logs.

- **Estado**: ALPHA (listo para pruebas)
- **Pruebas necesarias**: Ejecución completa en Parrot OS 6.4
- **Problemas conocidos**: Ver READMEs individuales de herramientas

## Criterios de Promoción (ALPHA → BETA)

Las herramientas pasan a BETA cuando:
1. ✅ Probadas exitosamente en Parrot OS 6.4
2. ✅ Sin crashes o comportamiento inesperado
3. ✅ Salida validada contra logs reales
4. ✅ Errores menores (si hay) documentados
5. ✅ Usada en al menos un escenario real

## Cómo Probar

1. **Prerequisitos:**
   ```bash
   chmod +x log_analysis/*/*.sh
   ```

2. **Probar brute_force_checker:**
   ```bash
   sudo ./log_analysis/brute_force_checker/brute_force_checker.sh /var/log/auth.log
   ```

3. **Probar log_analyzer:**
   ```bash
   ./log_analysis/log_analyzer/log_analyzer.sh -f /var/log/auth.log -p "Failed" -C
   ```

4. **Reportar hallazgos:**
   - Anotar errores, crashes o salida inesperada
   - Rendimiento en archivos grandes (>10MB)
   - Precisión de extracción de campos en tu sistema

## Retroalimentación

Reportar problemas o sugerencias para cada herramienta en su propio README bajo la sección "Problemas Conocidos".

---

**Última Actualización:** 25 de diciembre de 2025
