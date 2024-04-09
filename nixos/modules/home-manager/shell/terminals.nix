{ pkgs, lib, ... }:
let
  font = "Source Code Pro";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
        import = ["/home/dwaris/.dotfiles/nixos/modules/home-manager/shell/themes/alacritty/rose-pine/rose-pine.toml"];
        live_config_reload = true;
        window = {
            startup_mode = "Maximized";
            decorations = "full";
            opacity = 1.0;
            dynamic_title = true;
        };

        shell = {
            args = ["-l" "-c" "tmux attach || tmux"];
            program = "${pkgs.bash}/bin/bash";
        };

        font = {
            normal.family = font;
            bold.family = font;
            italic.family = font;
            size = 12;
        };
    };
  };
}
