#!/bin/sh

# Farben für die Konsole
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${CYAN}==============================================${NC}"
echo -e "${CYAN}        FritzView Universal Installer         ${NC}"
echo -e "${CYAN}==============================================${NC}"
echo ""

# 1. Speicherziele auf der FritzBox ermitteln
NAND_PATH="/var/media/ftp/internal_memory"
USB_PATHS=$(ls -d /var/media/ftp/* 2>/dev/null | grep -v "internal_memory")

echo "Bitte wähle den Installationsort:"
echo ""

COUNT=1
OPT_NAND=""
OPT_USB=""

if [ -d "$NAND_PATH" ]; then
    echo -e "  [${COUNT}] ${GREEN}Interner NAND-Speicher${NC} ($NAND_PATH/fritzview)"
    OPT_NAND=$COUNT
    COUNT=$((COUNT + 1))
fi

if [ -n "$USB_PATHS" ]; then
    FIRST_USB=$(echo "$USB_PATHS" | head -n 1)
    echo -e "  [${COUNT}] ${GREEN}USB-Speicher${NC} ($FIRST_USB/fritzview)"
    OPT_USB=$COUNT
    COUNT=$((COUNT + 1))
fi

echo -e "  [${COUNT}] ${YELLOW}RAM / Test-Modus${NC} (/tmp/fritzview - nach Reboot weg!)"
OPT_RAM=$COUNT

echo ""
read -p "Deine Wahl [1-$COUNT]: " CHOICE

# 2. Auswertung der Wahl
PERSISTENT=1

if [ "$CHOICE" -eq "$OPT_RAM" ]; then
    TARGET_DIR="/tmp/fritzview"
    PERSISTENT=0
    echo -e "\n${YELLOW}-> Test-Modus gewählt. Nach einem Reboot ist FritzView komplett weg.${NC}"
elif [ -n "$OPT_NAND" ] && [ "$CHOICE" -eq "$OPT_NAND" ]; then
    TARGET_DIR="$NAND_PATH/fritzview"
elif [ -n "$OPT_USB" ] && [ "$CHOICE" -eq "$OPT_USB" ]; then
    TARGET_DIR="$FIRST_USB/fritzview"
else
    echo -e "${RED}Ungültige Auswahl. Abbruch.${NC}"
    exit 1
fi

echo -e "\n${CYAN}[1/4] Erstelle Zielverzeichnis: $TARGET_DIR...${NC}"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit 1

# 3. Projekt von GitHub herunterladen und entpacken
echo -e "${CYAN}[2/4] Lade FritzView Dateien von GitHub...${NC}"
wget -qO- "https://github.com/Benni16v/FritzView/archive/refs/heads/main.tar.gz" | tar xz --strip-components=1

WEBIF_SOURCE="$TARGET_DIR/webif"
mkdir -p "$WEBIF_SOURCE"

# 4. WebIF Verlinkung für den Webserver setzen (ip.der.box/fritzview)
echo -e "${CYAN}[3/4] Richte WebIF (ip.der.box/fritzview) ein...${NC}"
TARGET_DIRS=("/usr/mww" "/var/html" "/usr/www/html")

for TARGET in "${TARGET_DIRS[@]}"; do
    if [ -d "$TARGET" ]; then
        ln -sf "$WEBIF_SOURCE" "$TARGET/fritzview"
        echo "   -> Symlink erstellt in $TARGET/fritzview"
    fi
done

# 5. Autostart in rc.custom eintragen (nur bei dauerhafter Installation)
echo -e "${CYAN}[4/4] Prüfe Autostart-Konfiguration...${NC}"
if [ "$PERSISTENT" -eq 1 ]; then
    RC_CUSTOM="/tmp/flash/mod/rc.custom"
    
    # Pfad korrigiert: $TARGET_DIR/src/fritzview.sh
    AUTO_CMD="[ -d $WEBIF_SOURCE ] && for d in /usr/mww /var/html /usr/www/html; do [ -d \$d ] && ln -sf $WEBIF_SOURCE \$d/fritzview; done\n$TARGET_DIR/src/fritzview.sh &"

    if [ -f "$RC_CUSTOM" ]; then
        if ! grep -q "FritzView Start" "$RC_CUSTOM"; then
            echo "" >> "$RC_CUSTOM"
            echo "# FritzView Start & WebIF" >> "$RC_CUSTOM"
            echo -e "$AUTO_CMD" >> "$RC_CUSTOM"
            
            if command -v modsave >/dev/null 2>&1; then
                modsave flash >/dev/null 2>&1
                echo -e "   -> Dauerhaft im Freetz-Flash gespeichert."
            fi
        fi
    fi
else
    echo -e "${YELLOW}   -> RAM-Modus: Kein Autostart eingetragen.${NC}"
fi

echo ""
echo -e "${GREEN}==============================================${NC}"
echo -e "${GREEN}   FritzView erfolgreich eingerichtet!        ${NC}"
echo -e "${GREEN}   WebIF: http://<IP-deiner-Box>/fritzview   ${NC}"
echo -e "${GREEN}==============================================${NC}"
