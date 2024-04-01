{ config, pkgs, ... }: {
    programs.tmux = {
        enable = true;
        shortcut = "f";
        terminal = "tmux-256color";
        escapeTime = 0;

        keyMode = "vi";
        historyLimit = 100000;
        clock24 = true;

        enableMouse = true;

        extraConfig = ''
            set -as terminal-overrides ",alacritty:RGB"
            set-option -g focus-events on
            set -g renumber-windows on

            # Split horiziontal and vertical splits, instead of % and "
            # Also open them in the same directory
            bind-key v split-window -h -c '#{pane_current_path}'
            bind-key s split-window -v -c '#{pane_current_path}'

            bind-key -T edit-mode-vi Up send-keys -X history-up
            bind-key -T edit-mode-vi Down send-keys -X history-down

            # Set title
            set -g set-titles on
            set -g set-titles-string "#T"

            # Equally resize all panes
            bind-key = select-layout even-horizontal
            bind-key | select-layout even-vertical

            # Resize panes
            bind-key J resize-pane -D 10
            bind-key K resize-pane -U 10
            bind-key H resize-pane -L 10
            bind-key L resize-pane -R 10

            # Select panes
            bind-key j select-pane -D
            bind-key k select-pane -U
            bind-key h select-pane -L
            bind-key l select-pane -R

            # Disable confirm before killing
            bind-key x kill-pane

            set -g status-position top
            set -g status-bg "#11111b"
            set -g status-fg "#f9e2af"
            set -g status-left ""
            set -g status-right "#{?client_prefix, *, } #(whoami)@#h #[fg=#11111b, bg=#585b70,bold] %d/%m #[fg=#11111b,bg=#9399b2,bold] %H:%M"
            set -g status-right-length 50
            set -g status-left-length 20

            setw -g window-status-current-format "#I#[fg=#a6adc8]:#[fg=#cdd6f4]#W#[fg=#94e2d5]#F"
            setw -g window-status-format "#I#[fg=#313244]:#[fg=#6c7086]#W#[fg=#6c7086]#F"
        '';
    };
