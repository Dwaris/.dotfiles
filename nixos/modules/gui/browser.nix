{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    firefox
    (chromium.override { enableWideVine = true; })
    tor-browser
  ];
}
