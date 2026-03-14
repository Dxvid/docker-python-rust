#!/usr/bin/env bash
set -euo pipefail

# --- Konfiguration ---
IMAGE_NAME="davidkronlid/python-rust"

# --- Datumtagg ---
DATE_TAG=$(date +%Y-%m-%d)

echo "Bygger Docker-image..."
docker build -t "${IMAGE_NAME}:${DATE_TAG}" -t "${IMAGE_NAME}:latest" .
