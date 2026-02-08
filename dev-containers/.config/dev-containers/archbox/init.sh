#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="dev-container"
BOX_NAME="dev"

echo "▶ Building image: $IMAGE_NAME"
podman build -t "$IMAGE_NAME" .

echo "▶ Creating distrobox: $BOX_NAME (if missing)"
if ! distrobox list | grep -q "^$BOX_NAME\s"; then
  distrobox create --name "$BOX_NAME" --image "$IMAGE_NAME"
else
  echo "✔ Distrobox '$BOX_NAME' already exists, skipping creation"
fi

echo "▶ Initializing distrobox environment"
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
distrobox enter "$BOX_NAME" -- bash "$SCRIPT_DIR/distrobox-init.sh"

echo "▶ Entering distrobox shell"
exec distrobox enter "$BOX_NAME"
