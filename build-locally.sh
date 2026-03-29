#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------
# Default path if none provided
# ---------------------------------------------
VARIANT_PATH="${1:-opensuse/tumbleweed}"

# Remove trailing slash(es)
VARIANT_PATH="${VARIANT_PATH%/}"

if [ ! -d "$VARIANT_PATH" ]; then
    echo "Error: Directory '$VARIANT_PATH' does not exist."
    exit 1
fi

DOCKERFILE="$VARIANT_PATH/Dockerfile"
if [ ! -f "$DOCKERFILE" ]; then
    echo "Error: No Dockerfile found at $DOCKERFILE"
    exit 1
fi

echo "Building Docker image from: $DOCKERFILE"

# ---------------------------------------------
# Build the image (verbose, pull latest base)
# ---------------------------------------------
IIDFILE=$(mktemp)

docker build \
  --pull \
  --progress=plain \
  -f "$DOCKERFILE" "$VARIANT_PATH" \
  --iidfile "$IIDFILE"

IMAGE_ID=$(cat "$IIDFILE")
rm "$IIDFILE"

echo "Built image ID: $IMAGE_ID"

# ---------------------------------------------
# Extract versions from inside the image
# ---------------------------------------------
PYTHON_VERSION=$(docker run --rm "$IMAGE_ID" python3 --version | awk '{print $2}')
RUST_VERSION=$(docker run --rm "$IMAGE_ID" rustc --version | awk '{print $2}')
OS_VERSION=$(docker run --rm "$IMAGE_ID" bash -c "source /etc/os-release && echo \$VERSION_ID")

# ---------------------------------------------
# Extract distro + variant from path
# e.g. opensuse/tumbleweed → opensuse-tumbleweed
# ---------------------------------------------
DISTRO_TAG=$(echo "$VARIANT_PATH" | tr '/' '-')

# ---------------------------------------------
# Timestamp (date + time)
# ---------------------------------------------
TIMESTAMP=$(date +'%Y%m%d-%H%M')

# ---------------------------------------------
# Compose final tag
# ---------------------------------------------
FINAL_TAG="${DISTRO_TAG}-${OS_VERSION}-py${PYTHON_VERSION}-rust${RUST_VERSION}-${TIMESTAMP}"

echo "Final local tag:"
echo "$FINAL_TAG"

# ---------------------------------------------
# Apply tag locally
# ---------------------------------------------
docker tag "$IMAGE_ID" "davidkronlid/python-rust:${FINAL_TAG}"

echo "Image tagged locally as:"
echo "davidkronlid/python-rust:${FINAL_TAG}"
