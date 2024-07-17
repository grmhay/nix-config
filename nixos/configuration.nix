# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Make sure firefox is installed - move to a module later?
  programs.firefox.enable = true;

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Rest of current configuration

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  # Disk encryption
  boot.initrd.luks.devices."luks-8c534578-0ed6-4efb-9819-8adab714e3eb".
  device = "/dev/disk/by-uuid/8c534578-0ed6-4efb-9819-8adab714e3eb";

  # filesystem options for SSD Optimization
  services.fstrim.enable = true;

  # Downgrade to enable fingerprint reader on Framework 13
  services.fwupd.enable = true;
  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  services.fwupd.package =
    (import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
        sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
      }) {
        inherit (pkgs) system;
      })
    .fwupd;


  # Sleep then hibernate
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

  # Set your hostname and enable NetworkManager
  networking.hostName = "florence";
  networking.networkmanager.enable = true;

  # Timezone setting
  time.timeZone = "America/Phoenix"; 

  # TODO - Put the rest of the internalization settings from original config in here
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Gnome as last resort option
  xdg.portal = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];


  # Default system font

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    grmhay = {
      isNormalUser = true;
      description = "Graeme Hay";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager"];
      uid = 1001;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  # Totally fine to leave this set at the initial install version
  system.stateVersion = "24.05";
}
