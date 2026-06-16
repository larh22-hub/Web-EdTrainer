#!/usr/bin/env bash
# Regenera el ZIP desplegable en Dokploy a partir de los archivos actuales de deck-unad/.
# Uso:  deck-unad/deploy/build-zip.sh [carpeta-destino]   (por defecto ~/Downloads)
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # deck-unad/deploy
SRC="$(dirname "$HERE")"                                # deck-unad
NAME="edtrainer-taller-unad"
OUT_DIR="${1:-$HOME/Downloads}"

mkdir -p "$OUT_DIR"
TMP="$(mktemp -d)"
BUILD="$TMP/$NAME"
mkdir -p "$BUILD/site/assets"

# Archivos de la presentación (el deck pasa a ser index.html para servirse en la raíz)
cp "$SRC/index_unad_pdi_taller.html" "$BUILD/site/index.html"
cp "$SRC/deck.css" "$SRC/deck-stage.js" "$SRC/diagnostico-live.html" "$BUILD/site/"
cp "$SRC"/assets/*.png "$BUILD/site/assets/"

# Config de despliegue
cp "$HERE/Dockerfile" "$HERE/nginx.conf" "$HERE/README.md" "$BUILD/"

ZIP="$OUT_DIR/$NAME-dokploy.zip"
rm -f "$ZIP"
# Dokploy busca el Dockerfile en la RAÍZ del ZIP: empaquetamos el contenido
# de $BUILD (Dockerfile, nginx.conf, README.md, site/) sin carpeta contenedora.
( cd "$BUILD" && zip -r -q "$ZIP" . -x '*.DS_Store' )
rm -rf "$TMP"

echo "ZIP creado: $ZIP"
unzip -l "$ZIP"
