# Changelog

Alle wichtigen Änderungen am Projekt FRITZ!View werden in dieser Datei dokumentiert.

## [0.2.0] - 2026-08

### Neu
* **TR-064 Library:** Vollständige Eigenentwicklung für AVM-Schnittstellen
* **System-Module:** WAN-, DSL-, WLAN-, Hosts-, Network- und Box-Modul
* **Testframework:** Integrierte Testumgebung für Schnittstellen
* **Credentials:** Auslagerung sensibler Anmeldedaten in `credentials.conf`
* **WebIF Update-System:** Direktes Online-Update über CGI/GitHub inklusive Schutz der `credentials.conf`

### Verbessert
* Projektstruktur und Pfad-Handling überarbeitet
* Konfigurations-Logik und Initialisierung optimiert

### Behoben
* Fehlerhafte `BASE`-Pfad-Ermittlung behoben
* Handhabung von Digest-Authentifizierung korrigiert

---

## [0.1.0] - "Genesis"

* Projekt-Init und grundlegende Repository-Struktur
