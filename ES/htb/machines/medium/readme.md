# Máquinas Medium

Desafíos de penetration testing de nivel intermedio. Requieren combinación de enumeración, explotación y escalación de privilegios.

## Vista General de Dificultad

- **Alcance:** Múltiples servicios o explotación multi-etapa
- **Habilidades:** Enumeración avanzada, explotación personalizada, escalación de privilegios, movimiento lateral
- **Tiempo:** 2 - 6 horas
- **Prerequisitos:** Experiencia con máquinas Easy, conocimiento de escalación de privilegios Linux

## Plataformas Objetivo

- HackTheBox
- TryHackMe (salas medium)

## Progreso

⬜⬜⬜⬜⬜ | **0/175 completadas (0%)**

| Máquina | Plataforma | Categoría | Fecha | Estado |
|---------|----------|----------|------|--------|
| | | | | |

## Flujo de Trabajo Típico

1. **Reconocimiento:** Enumeración completa de puertos y servicios
2. **Enumeración:** Aplicación web, API, protocolos personalizados
3. **Acceso Inicial:** Explotación de vulnerabilidad descubierta
4. **Escalación de Privilegios:** Enumeración local y cadena de exploits
5. **Post-Explotación:** Recopilación de evidencia, documentación

## Progreso

**0/175 completadas (0%)**

---

## 📋 Máquinas

| # | Máquina | OS | Enfoque | Estado |
|---|---------|-----|--------|--------|
| (Planificado) | | | Web / Network / Linux | ⏳ |

---

## Consejos

- Escaneo TCP/UDP completo: `nmap -p- -sV <target>`
- Fuzzing web: `ffuf -w wordlist.txt -u http://target/FUZZ`
- LinEnum para enumeración de escalación de privilegios
- Mantén notas detalladas sobre permisos y servicios

---

## 🔗 Volver a Máquinas

[← Machines](../readme.md) | [← HackTheBox](../../../readme.md)

---

**Última Actualización:** 12 de enero de 2026
