{ pkgs, vars, ... }:

{
  imports = (import ../modules/nixos/shell ++ import ../modules/nixos/services);

  # Users
  users.groups."${vars.user}".gid = 1000;
  users.users."${vars.user}" = {
    isNormalUser = true;
    uid = 1000;
    group = "${vars.user}";
    extraGroups = [ "wheel" "users" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "${vars.sshKey}" ];
  };

  # Nix
  nix = {
    package = pkgs.nixVersions.unstable;
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  # Networking
  networking = {
    hostName = "server";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Timezone, internationalization and localization
  time.timeZone = "Etc/UTC";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
    extraLocaleSettings = { LC_MONETARY = "en_GB.UTF-8"; };
  };
  console.keyMap = "us";

  # Packages
  environment.systemPackages = with pkgs; [
    appimage-run # Runs AppImages on NixOS
    bind # DNS server and utilities
    coreutils # GNU utilities
    efibootmgr # EFI boot entry manager
    exiftool # Image information
    ffmpeg-full # Audio and video processing
    file # File type information
    git # Version control
    glxinfo # Test utilities for OpenGL
    htop # Resource management
    imagemagick # Image processing
    inxi # System information
    lazygit # TUI Git client
    lm_sensors # Hardware sensors
    lshw # Hardware management
    nix-index # Nix file database
    nix-tree # Nix store explorer
    p7zip # 7-Zip archive management
    pciutils # PCI management
    ranger # File explorer
    rar # Rar archive management
    rsync # Sync tool
    smartmontools # Disk management
    tmux # Terminal multiplexer
    tree # Depth indented dir listing
    unrar # Rar archive management
    unzip # Zip archive management
    usbutils # USB management
    vim # Text editor
    xdg-user-dirs # XDG dir management
    zip # Zip archive management

    # Neovim
    cargo
    fd
    gcc
    go
    jq
    neovim
    nixfmt
    nodejs
    ripgrep
  ];

  system.stateVersion = "23.11";
}
