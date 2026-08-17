#!/bin/sh

# Farben für die Konsole
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# Ermittelt das FritzView-Hauptverzeichnis (egal ob update.sh im Root oder in src/ liegt)
SELF_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SELF_DIR/../src/fritzview.sh" ]; then
    SCRIPT_DIR="$(cd "$SELF_DIR/.." && pwd)"
else
    SCRIPT_DIR="$SELF_DIR"
fi

printf "${CYAN}=== FritzView Update gestartet ===${NC}\n"

if [ ! -d "$SCRIPT_DIR" ] || [ ! -d "$SCRIPT_DIR/src" ]; then
    printf "${RED}Fehler: FritzView-Verzeichnis nicht gefunden! ($SCRIPT_DIR)${NC}\n"
    exit 1
fi

TMP_DIR="/tmp/fritzview_update"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# 1. Lokale Zugangsdaten und Konfigurationen sichern
if [ -f "$SCRIPT_DIR/credentials.conf" ]; then
    cp "$SCRIPT_DIR/credentials.conf" /tmp/credentials.conf.bak
fi

printf "${CYAN}[1/3] Lade neueste Version von GitHub...${NC}\n"
if wget -qO- "https://github.com/Benni16v/FritzView/archive/refs/heads/main.tar.gz" | tar xz -C "$TMP_DIR" --strip-components=1; then
    
    printf "${CYAN}[2/3] Aktualisiere Dateien & Symlinks...${NC}\n"
    
    # Verzeichnisse aktualisieren
    cp -rf "$TMP_DIR/src" "$SCRIPT_DIR/" 2>/dev/null
    cp -rf "$TMP_DIR/webif" "$SCRIPT_DIR/" 2>/dev/null
    
    # Einzelne Skripte im Root erneuern, falls vorhanden
    [ -f "$TMP_DIR/setup.sh" ] && cp -f "$TMP_DIR/setup.sh" "$SCRIPT_DIR/" 2>/dev/null
    [ -f "$TMP_DIR/update.sh" ] && cp -f "$TMP_DIR/update.sh" "$SCRIPT_DIR/" 2>/dev/null

    # 2. Gesicherte credentials.conf wieder zurückspielen
    if [ -f /tmp/credentials.conf.bak ]; then
        cp /tmp/credentials.conf.bak "$SCRIPT_DIR/credentials.conf"
        rm -f /tmp/credentials.conf.bak
    fi
    
    # 3. WebIF Symlink für Port 81 sicherstellen
    mkdir -p /var/mww
    ln -sf "$SCRIPT_DIR/webif" /var/mww/fritzview
    
    rm -rf "$TMP_DIR"
    
    printf "${CYAN}[3/3] Starte FritzView-Hintergrunddienst neu...${NC}\n"
    pkill -f "fritzview.sh" 2>/dev/null
    
    if [ -f "$SCRIPT_DIR/src/fritzview.sh" ]; then
        chmod +x "$SCRIPT_DIR/src/fritzview.sh"
        nohup "$SCRIPT_DIR/src/fritzview.sh" >/dev/null 2>&1 &
    fi

    printf "${GREEN}=== Update erfolgreich abgeschlossen! ===${NC}\n"
    printf "${GREEN}WebIF: http://<IP-deiner-Box>:81/fritzview${NC}\n"
    exit 0
else
    printf "${RED}Fehler beim Download! Abbruch.${NC}\n"
    rm -rf "$TMP_DIR"
    exit 1
fi
