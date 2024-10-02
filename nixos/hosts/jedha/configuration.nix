# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../modules

    ../../modules/cli

    ../../modules/gui
    ../../modules/gui/gaming
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot = {
    enable = false;
    configurationLimit = 10;
  };
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.supportedFilesystems = [
    "zfs"
    "ntfs"
  ];

  boot.zfs.requestEncryptionCredentials = true;
  boot.zfs.forceImportRoot = true;

  boot.initrd.systemd.enable = true;
  boot.initrd.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [
    "zfs"
    "amdgpu"
  ];
  boot.kernelParams = [
    "video=DP-1:2560x1440@144"
    "video=HDMI-A-1:1920x1080@75"
  ];

  networking.hostName = "jedha"; # Define your hostname.
  networking.hostId = "74f65184";

  environment.systemPackages = with pkgs; [
    nfs-utils
    sshfs
    sbctl

    qbittorrent
    easyeffects
  ];

  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  security.pki.certificates = [ "/etc/ssl/certs/root_ca.crt" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.flatpak.enable = false;
  services.printing.enable = false;
  services.fwupd.enable = true;

  virtualisation.docker.enable = false;

  programs.adb.enable = true;
  users.users.dwaris.extraGroups = [
    "networkmanager"
    "docker"
    "adbusers"
  ];

  hardware.bluetooth.enable = false;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.pipewire.extraConfig.pipewire."10-clock-rate" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [
        44100
        48000
        88200
        96000
      ];
    };
  };

  #services.desktopManager.cosmic.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
