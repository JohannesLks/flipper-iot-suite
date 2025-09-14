#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Furi SDK holen, wenn nicht vorhanden
if [ ! -d "$ROOT_DIR/_fw" ]; then
  echo "[i] Klone Flipper Zero Firmware für SDK..."
  rm -rf "$ROOT_DIR/_fw"
  git clone --depth=1 https://github.com/flipperdevices/flipperzero-firmware.git "$ROOT_DIR/_fw"
fi

# Sanity-Checks
test -f "$ROOT_DIR/fap.yml" || { echo "[!] fap.yml fehlt im Projektwurzelordner"; exit 1; }
test -f "$ROOT_DIR/Makefile" || { echo "[!] Makefile fehlt im Projektwurzelordner"; exit 1; }
test -d "$ROOT_DIR/_fw" || { echo "[!] Firmware-Repository nicht gefunden"; exit 1; }

# Build im Container (Arbeitsverzeichnis ist /work)
if command -v docker >/dev/null 2>&1; then
  echo "[i] Verwende Docker für den Build..."
  if docker run --rm --entrypoint="" \
    -v "$ROOT_DIR":/work \
    -w /work \
    -e FURI_SDK_PATH=/work/_fw \
    flipperdevices/flipperzero-toolchain:latest \
    /bin/bash -c 'echo "=== Make Build ===" && make clean && make -j4'; then
    echo "[i] Build erfolgreich!"
  else
    echo "[!] Docker-Build fehlgeschlagen. Mögliche Lösungen:"
    echo "1. Mit sudo ausführen: sudo ./build.sh"
    echo "2. Benutzer zur docker-Gruppe hinzufügen: sudo usermod -aG docker \$USER"
    echo "3. Docker-Daemon starten: sudo systemctl start docker"
    echo "4. Neu anmelden nach Gruppenänderung"
    exit 1
  fi
else
  echo "[!] Docker nicht gefunden. Installation:"
  echo "1. sudo apt update && sudo apt install docker.io"
  echo "2. sudo systemctl start docker"
  echo "3. sudo usermod -aG docker \$USER"
  echo "4. Neu anmelden"
  exit 1
fi

echo
echo "[i] Fertig. Artefakte:"
ls -l "$ROOT_DIR"/*.fap 2>/dev/null || echo "[!] Keine .fap Dateien gefunden"
