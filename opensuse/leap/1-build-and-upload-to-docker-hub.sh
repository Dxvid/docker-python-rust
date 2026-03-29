#!/usr/bin/env bash
set -euo pipefail

# --- Konfiguration ---
IMAGE_NAME="davidkronlid/python-rust"

VERSION_TAG=opensuse-leap16-python3-rust1

# --- Datumtagg ---
DATE_TAG=$(date +%Y%m%d)

echo "Bygger Docker-image..."
docker build -t "${IMAGE_NAME}:${VERSION_TAG}" -t "${IMAGE_NAME}:${VERSION_TAG}-${DATE_TAG}" .

echo "Loggar in på Docker Hub..."
docker login

echo "Pushar tagg:"
docker push "${IMAGE_NAME}:${VERSION_TAG}"

echo "Pushar tagg:"
docker push "${IMAGE_NAME}:${VERSION_TAG}-${DATE_TAG}"

echo "Klart! Image uppladdad som:"
echo "  - ${IMAGE_NAME}:${DATE_TAG}"
echo "  - ${IMAGE_NAME}:latest"
