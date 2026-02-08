#!/usr/bin/env bash
set -euo pipefail

echo "▶ Inside distrobox: $(uname -a)"

# Install Nix
if command -v nix >/dev/null 2>&1; then
  echo "✔ Nix already installed"
else
  echo "▶ Installing Nix (single-user, no daemon)"
  curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
fi

# Enable flakes
mkdir -p "$HOME/.config/nix"
if [ ! -f "$HOME/.config/nix/nix.conf" ]; then
  cat <<EOF >"$HOME/.config/nix/nix.conf"
experimental-features = nix-command flakes
EOF
fi

# Install Fabric
if command -v fabric >/dev/null 2>&1; then
  echo "✔ Fabric already installed"
else
  echo "▶ Installing Fabric"
  curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash
fi

echo "✔ Distrobox initialized"
