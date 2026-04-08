#!/bin/bash

# 1. Update System
sudo pacman -Syu --noconfirm

# 2. Core Desktop Components (Niri + SDDM + Theme)
paru -S --needed sddm niri fzf fuzzel \
    cachyos-niri-noctalia noctalia sddm-theme-noctalia \
    cosmic-text-editor

# 3. CLI & Dev Tools
paru -S --needed neovim nodejs npm tailscale trayscale \
    steam-devices flatpak bazaar

# 4. Wayland Utilities (Choosing gammastep over redshift)
paru -S --needed wlsunset gammastep

# 5. Configuration
# Fixed the path from ~./ to ~/
sudo cp ~/sddm.conf /etc/sddm.conf
sudo systemctl enable --now sddm
sudo systemctl enable --now tailscaled

# 6. Flatpak Setup
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

APPS=(
    "com.bitwarden.desktop"
    "net.cozic.joplin.desktop"
    "org.onlyoffice.desktopeditors"
    "com.google.Chrome"
    "com.valvesoftware.steam"
    "dev.zed.Zed"
    "page.kramo.Cartridges"
    "io.ente.auth"
    "com.heroicgameslauncher.hgl"
)

for app in "${APPS[@]}"; do
    echo "Installing $app..."
    flatpak install -y flathub "$app"
done
