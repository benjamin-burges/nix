{ inputs, config, pkgs, lib,  ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Home manager config
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      nix = import ./home.nix;
      };
    };

  ############################
  # Base config
  ############################

  networking.hostName = "nix";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.synaptics.enable = false;
  services.xserver.libinput.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "au";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.nix = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    packages = with pkgs; [
      
    ];
  };

  environment.systemPackages = with pkgs; [
  vim
  neovim

  discord
  firefox
  sublime
  vlc
  
  # Not sure if needed
  libinput
#  libsecret  

 # Terminals
#  alacritty

  # Utils
  nmap
  yersinia
  wireshark
  neofetch
  lf
  htop
  btop
  dig
  tree
  git
  lazygit
  wget
  fzf
  tldr

  # Silly things
  lolcat
  sl 
  cmatrix
  fortune
  oneko

  # Hyprland things
  waybar
  dunst
  libnotify
  swww
  kitty
  rofi-wayland
  (pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true" ];
    })
  )
  ];

 #####################################################
 # Program config
 #####################################################
  # zsh 
  programs.zsh.enable = true;

  # Wireshark
  programs.wireshark.enable = true;

  # Hyprland config
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
    nvidia.open = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
