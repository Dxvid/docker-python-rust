#!/usr/bin/env bash
set -euo pipefail

# --- Konfiguration ---
IMAGE_NAME="davidkronlid/python-rust"

VERSION_TAG=opensuse-leap16-python3-rust1

# --- Datumtagg ---
DATE_TAG=${VERSION_TAG}_$(date +%Y%m%d)

echo "Bygger Docker-image..."
docker build --pull --progress "plain" -t "${IMAGE_NAME}:${VERSION_TAG}" -t "${IMAGE_NAME}:${DATE_TAG}" .
