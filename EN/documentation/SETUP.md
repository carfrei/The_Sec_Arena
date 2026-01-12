# Environment Setup Guide

Complete setup instructions for The Sec Arena security testing environment.

---

## 🖥️ Operating System

### Parrot Security OS 6.4 (Lorikeet)

**Why Parrot OS:**
- Lightweight and fast
- Pre-installed penetration testing tools
- Active community and regular updates
- Privacy-focused by default

**Installation:**
1. Download ISO from [parrotsec.org](https://www.parrotsec.org/)
2. Create bootable USB with Rufus or Etcher
3. Boot and follow installation wizard
4. Update system: `sudo apt update && sudo apt upgrade`

---

## 📦 Required Tools

### Essential Packages

```bash
sudo apt install -y \
  python3 python3-pip \
  git curl wget \
  nmap nc openvpn \
  vim nano \
  net-tools
```

### Python Dependencies

```bash
pip3 install \
  requests \
  beautifulsoup4 \
  paramiko \
  pycryptodome \
  sqlalchemy
```

---

## 🔑 HackTheBox & Platforms Setup

### HackTheBox VPN

1. Download OpenVPN config from HTB account settings
2. Connect: `sudo openvpn htb_config.ovpn`
3. Verify connection: `ping 10.10.10.1`

### OverTheWire

1. No special setup - SSH based
2. Create account at [overthewire.org](https://overthewire.org/)
3. SSH command: `ssh bandit0@bandit.labs.overthewire.org -p 2220`

### VulnHub

1. Download VMs from [vulnhub.com](https://www.vulnhub.com/)
2. Import OVA files into VirtualBox
3. Configure host-only networking for isolation

---

## 🐳 Virtual Machine Configuration

### VirtualBox Setup

```bash
sudo apt install virtualbox virtualbox-ext-pack
```

**Network Configuration:**
- Adapter 1: Host-only (for isolated testing)
- Adapter 2: NAT (for internet access, optional)

---

## 📝 Repository Configuration

Clone and setup The Sec Arena:

```bash
git clone https://github.com/DrCarfrei/The_Sec_Arena.git
cd The_Sec_Arena
git config user.email "your_email@example.com"
git config user.name "Your Name"
```

---

## ✅ Verification Checklist

- [ ] Parrot OS installed and updated
- [ ] Python 3 and pip3 working
- [ ] Git configured with credentials
- [ ] HackTheBox VPN connected
- [ ] OverTheWire SSH accessible
- [ ] VirtualBox ready for VMs
- [ ] Repository cloned locally

---

## 🆘 Troubleshooting

### VPN Connection Issues
```bash
# Check VPN status
sudo systemctl status openvpn@htb_config
# Restart VPN
sudo systemctl restart openvpn@htb_config
```

### Python Package Issues
```bash
# Update pip
pip3 install --upgrade pip
# Clear cache
pip3 cache purge
```

### Git Configuration
```bash
# Verify settings
git config --list
# Update credentials
git config --global credential.helper store
```

---

## 📚 Next Steps

1. Review [METHODOLOGY.md](METHODOLOGY.md) for workflow
2. Check [TOOLS.md](TOOLS.md) for custom utilities
3. Start with OverTheWire Bandit (beginner-friendly)
