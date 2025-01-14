{
  inputs,
  config,
  pkgs,
  ...
}:

{

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "eu";
    };
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security = {
    pam.services.gdm-password.enableGnomeKeyring = true;
  };
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpolkitagent
    hyprlock

    waybar
    pavucontrol
    dunst
    playerctl
    networkmanagerapplet
    rofi-wayland

    adwaita-icon-theme
    nautilus
    wl-clipboard
    libsecret
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  #  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
