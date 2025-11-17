# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


#let
#  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
#in
{



  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #(import "${home-manager}/nixos")    
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #home-manager.useGlobalPkgs = true;
  #home-manager.useUserPackages = true;
  #home-manager.backupFileExtension = "backup";
  #home-manager.users.meow = import ./home.nix;
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.hardwareClockInLocalTime = true;
  networking.hostName = "meowbook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "kime";
    };
  };
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meow = {
    isNormalUser = true;
    description = "meow";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Use SDDM as default DM
  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;
  # PipeWire
  #services.pipewire.enable = true;
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.power-profiles-daemon.enable = true;
  # Initialize Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  #programs.waybar.enable = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    git
    zsh
    busybox
    gcc
    clang-tools
    vscode
    hyprland
    hyprpaper
    hyprshot
    xfce.thunar
    libreoffice-qt6
    kitty
    ghostty
    waybar
    wofi
    nwg-look
    kdePackages.sddm
    glibc
    pipewire
    firefox
    fastfetch
    discord
    spotify
    hw-probe
    power-profiles-daemon
    aircrack-ng
    wireshark
    iw
    networkmanagerapplet 
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.nix-ld.enable = true;
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts-cjk-sans
    nerd-fonts.jetbrains-mono
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
