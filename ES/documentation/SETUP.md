# Guía de Configuración del Entorno

Instrucciones completas de configuración para el entorno de pruebas de seguridad de The Sec Arena.

---

## 🖥️ Sistema Operativo

### Parrot Security OS 6.4 (Lorikeet)

**Por qué Parrot OS:**
- Ligero y rápido
- Herramientas de penetration testing preinstaladas
- Comunidad activa y actualizaciones regulares
- Enfocado en privacidad por defecto

**Instalación:**
1. Descargar ISO desde [parrotsec.org](https://www.parrotsec.org/)
2. Crear USB booteable con Rufus o Etcher
3. Arrancar y seguir el asistente de instalación
4. Actualizar el sistema: `sudo apt update && sudo apt upgrade`

---

## 📦 Herramientas Requeridas

### Paquetes Esenciales

```bash
sudo apt install -y \
  python3 python3-pip \
  git curl wget \
  nmap nc openvpn \
  vim nano \
  net-tools
```

### Dependencias de Python

```bash
pip3 install \
  requests \
  beautifulsoup4 \
  paramiko \
  pycryptodome \
  sqlalchemy
```

---

## 🔑 Configuración de HackTheBox y Plataformas

### VPN de HackTheBox

1. Descargar configuración OpenVPN desde ajustes de cuenta HTB
2. Conectar: `sudo openvpn htb_config.ovpn`
3. Verificar conexión: `ping 10.10.10.1`

### OverTheWire

1. Sin configuración especial - basado en SSH
2. Crear cuenta en [overthewire.org](https://overthewire.org/)
3. Comando SSH: `ssh bandit0@bandit.labs.overthewire.org -p 2220`

### VulnHub

1. Descargar VMs desde [vulnhub.com](https://www.vulnhub.com/)
2. Importar archivos OVA en VirtualBox
3. Configurar red host-only para aislamiento

---

## 🐳 Configuración de Máquina Virtual

### Configuración de VirtualBox

```bash
sudo apt install virtualbox virtualbox-ext-pack
```

**Configuración de Red:**
- Adaptador 1: Host-only (para pruebas aisladas)
- Adaptador 2: NAT (para acceso a internet, opcional)

---

## 📝 Configuración del Repositorio

Clonar y configurar The Sec Arena:

```bash
git clone https://github.com/DrCarfrei/The_Sec_Arena.git
cd The_Sec_Arena
git config user.email "tu_email@ejemplo.com"
git config user.name "Tu Nombre"
```

---

## ✅ Lista de Verificación

- [ ] Parrot OS instalado y actualizado
- [ ] Python 3 y pip3 funcionando
- [ ] Git configurado con credenciales
- [ ] VPN de HackTheBox conectada
- [ ] SSH de OverTheWire accesible
- [ ] VirtualBox listo para VMs
- [ ] Repositorio clonado localmente

---

## 🆘 Solución de Problemas

### Problemas de Conexión VPN
```bash
# Verificar estado VPN
sudo systemctl status openvpn@htb_config
# Reiniciar VPN
sudo systemctl restart openvpn@htb_config
```

### Problemas con Paquetes de Python
```bash
# Actualizar pip
pip3 install --upgrade pip
# Limpiar caché
pip3 cache purge
```

### Configuración de Git
```bash
# Verificar configuración
git config --list
# Actualizar credenciales
git config --global credential.helper store
```

---

## 📚 Próximos Pasos

1. Revisar [METHODOLOGY.md](METHODOLOGY.md) para el flujo de trabajo
2. Consultar [TOOLS.md](TOOLS.md) para utilidades personalizadas
3. Comenzar con OverTheWire Bandit (amigable para principiantes)
