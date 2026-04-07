pacman -Syu
pacman -S paru
paru -S sddm fuzzel niri cachyos-niri-noctalia noctalia cosmic-text-editor bazaar ente-auth-bin redshift wlsunset neovim nodejs npm steam-devices tailscale trayscale gammastep flatpak
sudo systemctl enable -f sddm

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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

 # Install apps silently (-y assumes yes to all prompts)
for app in "${APPS[@]}"; do
    echo "Installing $app..."
    flatpak install -y flathub "$app"
done

