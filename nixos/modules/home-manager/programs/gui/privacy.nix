{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bitwarden-desktop
    veracrypt
    protonvpn-gui
  ];
}
