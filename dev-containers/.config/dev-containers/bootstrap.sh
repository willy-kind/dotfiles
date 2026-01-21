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

distrobox enter "$BOX_NAME" -- bash -lc '
  set -e

  echo "▶ Inside distrobox: $(uname -a)"

  if command -v nix >/dev/null 2>&1; then
    echo "✔ Nix already installed"
  else
    echo "▶ Installing Nix (single-user, no daemon)"
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
  fi

  # Enable flakes
  mkdir -p "$HOME/.config/nix"
  if [ ! -f "$HOME/.config/nix/nix.conf" ]; then
    cat <<EOF > "$HOME/.config/nix/nix.conf"
experimental-features = nix-command flakes
EOF
  fi

  echo "✔ Distrobox initialized"
'

echo "▶ Entering distrobox shell"
exec distrobox enter "$BOX_NAME" -- zsh
