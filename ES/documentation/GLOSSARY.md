# Glosario de Seguridad

Referencia rápida para términos comunes de seguridad usados en The Sec Arena.

---

## A

**API** - Application Programming Interface  
Método definido para que las aplicaciones de software se comuniquen e intercambien datos.

**Attack Surface**  
Todos los puntos donde un atacante podría potencialmente obtener entrada a un sistema.

**Authentication**  
Proceso de verificar la identidad (quién eres).

**Authorization**  
Proceso de determinar permisos (qué puedes hacer).

---

## B

**Binary Exploitation**  
Atacar ejecutables compilados para obtener acceso no autorizado o ejecución de código.

**Blind SQLi** - Blind SQL Injection  
Inyección SQL donde los mensajes de error no son visibles; usa inferencia basada en tiempos o booleanos.

**Brute Force**  
Intentar todas las combinaciones posibles para descifrar una contraseña o clave.

**Buffer Overflow**  
Escribir datos más allá del buffer asignado, corrompiendo la memoria adyacente.

---

## C

**Command Injection**  
Insertar comandos arbitrarios en la entrada de la aplicación que son ejecutados por el sistema.

**CSRF** - Cross-Site Request Forgery  
Ataque donde el usuario realiza acciones no deseadas sin saberlo en otro sitio.

**Cryptanalysis**  
Estudio de romper sistemas criptográficos sin la clave.

**CVE** - Common Vulnerabilities and Exposures  
Identificador único para vulnerabilidades de seguridad conocidas públicamente.

---

## D

**Deserialization**  
Convertir datos almacenados/transmitidos de vuelta a un objeto (puede ser explotado).

**DLL Injection**  
Inyectar código malicioso en un proceso en ejecución (Windows).

**DoS** - Denial of Service  
Ataque diseñado para hacer que un servicio no esté disponible.

---

## E

**Encryption**  
Convertir texto plano a texto cifrado usando un algoritmo y clave (reversible).

**Enumeration**  
Recopilación sistemática de información sobre un sistema o red objetivo.

**Exploit**  
Código/método que aprovecha una vulnerabilidad.

**Exposure**  
Divulgación no intencional de información sensible.

---

## F

**Forensics**  
Investigación de sistemas digitales para recuperar evidencia o entender qué sucedió.

**FSOP** - File Structure Overwrite Pointer  
Técnica de explotación avanzada dirigida a la estructura FILE en glibc.

---

## G

**Gadget Chain**  
Secuencia de fragmentos de código utilizados en ataques ROP (Return-Oriented Programming).

**Generic Publicly Available Exploit**  
Código de exploit listo para usar disponible para atacantes.

---

## H

**Hash Function**  
Función unidireccional que convierte la entrada a salida de tamaño fijo (no reversible en teoría).

**Heap Overflow**  
Buffer overflow en memoria heap en lugar de stack.

**Horizontal Privilege Escalation**  
Obtener acceso al mismo nivel de privilegio que otro usuario (movimiento lateral).

---

## I

**IOC** - Indicator of Compromise  
Evidencia de que un sistema ha sido comprometido (direcciones IP, hashes de archivos, dominios).

**Integer Overflow**  
Cuando un entero excede el valor máximo, causando comportamiento inesperado.

**IDS** - Intrusion Detection System  
Sistema de monitoreo de red que alerta sobre actividad sospechosa.

---

## J

**JWT** - JSON Web Token  
Mecanismo de autenticación basado en tokens usado en aplicaciones web.

---

## K

**Kerberos**  
Protocolo de autenticación de red (comúnmente usado en dominios Windows).

---

## L

**LDAP** - Lightweight Directory Access Protocol  
Protocolo para acceder a servicios de directorio (como Active Directory).

**Log Analysis**  
Examinar logs de sistema/aplicación para identificar patrones o incidentes.

---

## M

**MFA** - Multi-Factor Authentication  
Usar múltiples métodos de autenticación (contraseña + teléfono, etc).

**MITM** - Man-In-The-Middle  
Ataque donde el atacante intercepta la comunicación entre dos partes.

**Malware**  
Software malicioso diseñado para dañar o explotar un sistema.

---

## N

**NoSQL Injection**  
Inyectar consultas maliciosas en bases de datos NoSQL (similar a SQLi).

---

## O

**OWASP** - Open Web Application Security Project  
Organización sin fines de lucro enfocada en mejorar la seguridad de aplicaciones web.

**Obfuscation**  
Hacer que el código sea difícil de entender sin cambiar la funcionalidad.

---

## P

**Padding Oracle**  
Técnica de explotación que usa mensajes de error de validación de padding.

**Pentesting** - Penetration Testing  
Ataque simulado autorizado para encontrar vulnerabilidades.

**Privilege Escalation**  
Obtener acceso de nivel superior al actualmente autorizado.

**Payload**  
Datos o código usados en un exploit.

---

## Q

**Quantum Computing**  
Paradigma de computación que podría romper el cifrado actual (amenaza futura).

---

## R

**RCE** - Remote Code Execution  
Capacidad de ejecutar código arbitrario en un sistema remoto.

**Reverse Engineering**  
Analizar software/firmware para entender cómo funciona.

**ROP** - Return-Oriented Programming  
Técnica de explotación encadenando gadgets para ejecutar código arbitrario.

---

## S

**SQLi** - SQL Injection  
Insertar SQL malicioso en la entrada para manipular consultas de base de datos.

**SSTI** - Server-Side Template Injection  
Inyectar código de plantilla que se procesa del lado del servidor.

**SUID** - Set User ID  
Permiso de archivo que permite la ejecución como el propietario del archivo.

**Serialization**  
Convertir un objeto en un formato transmisible/almacenable.

**Sandbox**  
Entorno aislado para probar código no confiable de forma segura.

---

## T

**Time-Based Injection**  
Ataque que usa retrasos de tiempo para inferir información (timing de SQLi ciego).

**Traversal** (ver Path Traversal)

**Two-Factor Authentication** (ver MFA)

---

## U

**Unicode Normalization**  
Técnica para eludir filtros usando caracteres equivalentes.

**Unauthenticated Access**  
Obtener acceso sin credenciales válidas.

---

## V

**Vulnerability**  
Debilidad en el software que puede ser explotada.

**Vertical Privilege Escalation**  
Obtener acceso a un nivel de privilegio superior (usuario → admin).

---

## W

**WAF** - Web Application Firewall  
Dispositivo de seguridad que filtra tráfico HTTP/HTTPS.

**Weak Cryptography**  
Usar métodos de cifrado obsoletos o defectuosos.

**XSS** - Cross-Site Scripting  
Inyectar JavaScript malicioso en páginas web.

---

## X

**XXE** - XML External Entity  
Inyectar XML malicioso para leer archivos o realizar SSRF.

---

## Y

**YAML Deserialization**  
Explotar el análisis inseguro de YAML para ejecutar código.

---

## Z

**Zero-Day**  
Vulnerabilidad previamente desconocida sin parche disponible.

**Zeroconf**  
Configuración automática de red (puede exponer servicios).

---

## Referencia de Abreviaturas

| Abrev | Término Completo |
|------|-----------|
| API | Application Programming Interface |
| CSRF | Cross-Site Request Forgery |
| CVE | Common Vulnerabilities and Exposures |
| DDoS | Distributed Denial of Service |
| DNS | Domain Name System |
| FTP | File Transfer Protocol |
| HTTP | Hypertext Transfer Protocol |
| HTTPS | HTTP Secure |
| IP | Internet Protocol |
| JWT | JSON Web Token |
| LFI | Local File Inclusion |
| MITM | Man-In-The-Middle |
| OTP | One-Time Password |
| RCE | Remote Code Execution |
| RFI | Remote File Inclusion |
| SSH | Secure Shell |
| SQL | Structured Query Language |
| SQLi | SQL Injection |
| SSL | Secure Sockets Layer |
| SSRF | Server-Side Request Forgery |
| TLS | Transport Layer Security |
| URL | Uniform Resource Locator |
| VPN | Virtual Private Network |
| WAF | Web Application Firewall |
| XSS | Cross-Site Scripting |
| XXE | XML External Entity |

---

## Recursos Relacionados

- **OWASP:** https://owasp.org/
- **MITRE ATT&CK:** https://attack.mitre.org/
- **CyberChef Help:** https://gchq.github.io/CyberChef/
- **Security+ Study Guide:** Materiales oficiales de CompTIA

---

## Contribuyendo al Glosario

¿Encontraste términos faltantes? ¡Envía adiciones vía pull request!

---

*Última Actualización: 25 de diciembre de 2025*
