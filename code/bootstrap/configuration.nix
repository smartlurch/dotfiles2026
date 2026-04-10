{ config, pkgs, ... }:

{
  # 1. System & Hardware Basics
  networking.hostName = "nixos-desktop";
  nixpkgs.config.allowUnfree = true; # Required for Steam, Chrome, etc.

  # 2. Enable Graphics & Niri (Wayland)
  programs.niri.enable = true;
  
  # 3. Display Manager (SDDM) & Theming
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # On NixOS, we don't 'cp' sddm.conf. We define it or use themes like this:
    theme = "noctalia"; 
  };

  # 4. System Packages (The 'pacman' and 'paru' stuff)
  environment.systemPackages = with pkgs; [
    # Desktop Essentials
    fuzzel
    fzf
    cosmic-text-editor
    
    # Dev & CLI
    neovim
    nodejs_20
    bazaar
    git
    
    # VPN & Network
    tailscale
    trayscale
    
    # Blue light filters
    wlsunset
    gammastep
  ];

  # 5. Services (The 'systemctl enable' stuff)
  services.tailscale.enable = true;
  services.flatpak.enable = true;

  # 6. Gaming (Steam & steam-devices)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
  };

  # 7. Flatpaks 
  # NixOS doesn't natively "list" flatpaks in the config file easily without
  # a community module like 'nix-flatpak'. Usually, you'd run:
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # But for a pure Nix experience, you'd ideally use the Nix versions below:
  
  users.users.lurch = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [
      bitwarden
      joplin-desktop
      onlyoffice-bin
      google-chrome
      zed-editor
      cartridges
      ente-auth
      heroic
    ];
  };

  # 8. SDDM Config (The /etc/sddm.conf equivalent)
  # Instead of copying a file, we write it directly via Nix:
  environment.etc."sddm.conf".text = ''
    [Theme]
    Current=noctalia
  '';

  system.stateVersion = "24.11"; # Check the current version when installing
}
