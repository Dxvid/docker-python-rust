#!/usr/bin/env bash
set -euo pipefail

# --- Konfiguration ---
IMAGE_NAME="davidkronlid/python-rust"

VERSION_TAG=python3.13_rust1.94

# --- Datumtagg ---
DATE_TAG=${VERSION_TAG}_$(date +%Y-%m-%d)

echo "Bygger Docker-image..."
docker build -t "${IMAGE_NAME}:${VERSION_TAG}" -t "${IMAGE_NAME}:${DATE_TAG}" -t "${IMAGE_NAME}:latest" .

echo "Loggar in på Docker Hub..."
docker login

echo "Pushar tagg: ${DATE_TAG}"
docker push "${IMAGE_NAME}:${DATE_TAG}"

echo "Pushar tagg: latest"
docker push "${IMAGE_NAME}:latest"

echo "Klart! Image uppladdad som:"
echo "  - ${IMAGE_NAME}:${DATE_TAG}"
echo "  - ${IMAGE_NAME}:latest"
