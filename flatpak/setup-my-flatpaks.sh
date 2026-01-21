#!/usr/bin/env bash
set -e

# 1) Check if flatpak is installed
if ! command -v flatpak >/dev/null 2>&1; then
  echo "Flatpak is not installed."
  echo "Install it first, e.g. on Fedora:"
  echo "  sudo dnf install -y flatpak"
  exit 1
fi

echo "Flatpak is installed."

# 2) Add flathub remote if missing
echo "Adding Flathub remote (if needed)..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 3) Install apps
apps=(
  com.github.tchx84.Flatseal
  com.spotify.Client
  com.synology.SynologyDrive
  com.valvesoftware.Steam
  org.qbittorrent.qBittorrent
  org.videolan.VLC
)

echo "Installing Flatpaks..."
flatpak install -y flathub "${apps[@]}"

echo "Done."
