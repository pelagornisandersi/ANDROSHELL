# ANDROSHELL

> Automated Bash workflow for generating and hosting Android reverse TCP payloads with Metasploit for authorized cybersecurity lab environments.

---

## ⚠️ Legal & Ethical Notice

This project is intended strictly for **educational purposes**, **cybersecurity research**, and **authorized penetration testing** within lab environments or systems you explicitly own or have permission to assess.

Unauthorized use of this software against devices, networks, or individuals without consent may violate local, national, or international laws.

The author assumes no liability and is not responsible for misuse, damages, data loss, or illegal activities resulting from the use of this project.

**By using this repository, you agree to use it responsibly and ethically.**

---

## Overview

AndroShell automates parts of a typical Android reverse TCP shell testing workflow using:

- Bash scripting
- Metasploit Framework
- Python HTTP server
- Linux web hosting directories

The script streamlines repetitive setup tasks commonly performed during cybersecurity lab exercises.

---

## Features

- Automated APK payload generation
- Automatic payload placement into web directory
- Lightweight payload hosting through Python HTTP server
- Automatic Metasploit listener startup
- Simplified workflow for controlled security testing
- Terminal-based automation for Linux environments

---

## Supported Environment

Any Linux distribution. Recommended:

- Kali Linux
- Parrot OS
- Ubuntu-based pentesting environments

---

## Prerequisites

Ensure the following are installed and configured:

- Metasploit Framework (`msfvenom`)
- Python web server or Apache web service or accessible web directory

---

## Installation

```bash
git clone https://github.com/pelagornisandersi/ANDROSHELL.git
cd ANDROSHELL
```

---

## Usage

```bash
sudo ./androshell.sh
```

Follow the on-screen prompts to:

1. Enter your attacker IP (`LHOST`) and port (`LPORT`)
2. Let the script generate the APK payload via `msfvenom`
3. Payload is automatically moved to the web directory
4. Python HTTP server starts to serve the payload
5. Metasploit listener launches automatically

---

## Author

**GitHub:** [@pelagornisandersi](https://github.com/pelagornisandersi)

Cybersecurity student & security enthusiast building lab automation tools.

---

## Disclaimer

This tool is provided **as-is** for authorized lab use only. Always obtain explicit written permission before testing any device or network you do not own.
