#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$ROOT_DIR/furi-sdk" ]; then
  echo "Hole Furi SDK als Unterordner (read-only clone)…"
  git clone --depth=1 https://github.com/flipperdevices/flipperzero-firmware.git "$ROOT_DIR/_fw"
  ln -s "$ROOT_DIR/_fw/furi" "$ROOT_DIR/furi-sdk"
fi

docker run --rm -t \
  -v "$ROOT_DIR":/work \
  -e FURI_SDK_PATH=/work/furi-sdk \
  flipperdevices/flipperzero-toolchain:latest \
  bash -lc 'cmake -S . -B build && cmake --build build -j'

echo
echo "Fertig. Artefakt:"
ls -l build/*.fap
