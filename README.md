# FRITZ!View

> A modular dashboard framework for AVM FRITZ!Box devices powered by LCD4Linux.

Copyright (c) 2026 Benjamin Bilzer

FRITZ!View ist und bleibt Open Source.

Falls Dir das Projekt gefällt und Du die Entwicklung unterstützen
möchtest, wird es später eine freiwillige Spendenseite geben.

![Version](https://img.shields.io/badge/version-0.2.0-blue)
![Status](https://img.shields.io/badge/status-Development-orange)
![License](https://img.shields.io/badge/license-MIT-green)

---

### Platform Support

FRITZ!View läuft flexibel auf verschiedenen Systemen:

* ✓ Freetz / Freetz-NG
* ✓ OpenWrt
* ✓ Raspberry Pi
* ✓ Linux (Debian / Ubuntu / ALARM)
* ✓ Docker
* ✓ Architecture: x86 / ARM / MIPS

---

### Features

* **TR-064 Anbindung:** Direkte Abfrage von DSL, WAN, WLAN, Hosts und Telefonie
* **Display-Treiber:** Pearl AX206, Samsung SPF (Bilderrahmen), Console Mode
* **Boot & Themes:** Flexible Boot-Screens und anpassbare UI-Themes
* **Architektur:** Modularer Aufbau für Pages, Displays und Plugins
* **Offline-Modus:** Robustes Caching bei Verbindungsunterbrechungen

---

### Verzeichnisstruktur

```text
config/         # Konfigurationsdateien (z. B. credentials.conf)
src/modules/    # TR-064 Schnittstellen (WAN, DSL, WLAN, Hosts)
src/screens/    # Bildschirminhalte und Layouts
src/display/    # Display Engine
src/displays/   # Display-Treiber (Pearl, Samsung, Terminal)
webif/          # Web-Interface & CGI-Steuerung
themes/         # Farbschemata und Themes
docs/           # Dokumentation
installer/      # Setup- und Update-Skripte
tests/          # Testframework und Unittests

