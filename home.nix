{ pkgs, hyprland, hyprland-plugins, system, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.waybar.enable = true;
  services.mako.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # Use Hyprland from the hyprland flake
    package       = hyprland.packages.${system}.hyprland;
    portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;

    # Example plugin from hyprland-plugins flake
    plugins = [
      # hyprland-plugins.packages.${system}.borders-plus-plus
    ];

    settings = {

      # General
      general = {
	gaps_in = 8;
	gaps_out = 18;
	border_size = 3;
	col.active_border = "0xff9a7dff"; # Lavender purple
	col.inactive-border = "0x663b2b4e";
      };

      # Decoration
      decoration = {
	rounding = 14;
	drop_shadow = true;
	shadow_range = 20;
	shadow_render_power = 3;
	blur = {
	  enabled = true;
	  size = 8;
	  passes = 2;
	  ignore_opacity = true;
	  new_optimizations = true;
        };
      };

      # Animations
      animations = {
	enabled = true;
	bezier = "overshoot, 0.16, 0.9, 0.25, 1.05";
	animation = [
	  "windows, 1, 7, overshoot, popin 60%"
	  "border, 1, 10, default"
	  "fade, 1, 6, default"
	  "workspaces, 1, 6, overshoot, slide"
	];
      };

      # Autostart bar, dock, wallpaper
      exec-once = [
	"swww init" # && swww img <PATH TO IMAGE> --transition-type any
	"waybar"
	"nwg-dock-hyprland"
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

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

        # Screenshots
        "SUPER, Print, exec, grimblast save screen"	# fullscreen
        "SUPER SHIFT, Print, exec, grimblast save active"	# active
        "SUPER ALT, Print, exec, grimblast save area"	# area

        # Mouse Movement
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
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
      rofi-wayland

      # hyprland
      grim
      slurp
      grimblast
      waybar
      nwg-dock-hyprland
      swww
      mako
      catppuccin-gtk
      papirus-icon-theme
      # bibata-cursor-theme
    ];
  };
}
