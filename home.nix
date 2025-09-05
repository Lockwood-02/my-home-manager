{ pkgs, hyprland, hyprland-plugins, system, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # Use Hyprland from the hyprland flake
    package       = hyprland.packages.${system}.hyprland;
    portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;

    # Example plugin from hyprland-plugins flake
    plugins = [
      hyprland-plugins.packages.${system}.borders-plus-plus
    ];

    settings = {

      "plugin:borders-plus-plus" = {
        add_borders = 1;
    
        "col.border_1" = "rgb(ffffff)";
        "col.border_2" = "rgb(2222ff)";

        border_size_1 = 10;
        border_size_2 = -1;

        natural_rounding = "yes";
      };

      # input & keyboard
      input = {
        kb_layout = "us";                  # set your layout
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      # simple binds
      bind = [
        "SUPER, Return, exec, kitty"       # open terminal
        "SUPER, Q, killactive"             # close window
        "SUPER, F, fullscreen, 1"
        "SUPER, Space, exec, rofi -show drun"
        "SUPER SHIFT, E, exit"             # exit Hyprland
        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"
      ];

      # start a bar, etc.
      exec-once = [
        "waybar"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

    };

  };

  home = {
    username      = "lockwood";
    homeDirectory = "/home/lockwood";
    stateVersion  = "25.05";

    packages = with pkgs; [
      hello
      vscode
      kitty
    ];
  };
}
