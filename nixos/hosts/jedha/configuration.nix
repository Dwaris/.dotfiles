# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/nixos/defaults.nix
      ../../modules/nixos/gnome.nix
      ../../modules/nixos/steam.nix
    ];

  boot.loader.grub = {
    enable = true;
    default = "saved";
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    useOSProber = true;
    mirroredBoots = [
      { devices = [ "nodev"]; path = "/boot"; }
    ];
  };

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  networking.hostName = "jedha"; # Define your hostname.
  networking.hostId = "74f65184";

  programs.hyprland.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    gnomeExtensions.appindicator
    wl-clipboard
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;  

  security.pki.certificates = [ "/etc/ssl/certs/root_ca.crt" ];
  
  services.flatpak.enable = true;
  
  system.stateVersion = "23.11"; # Did you read the comment?
}
