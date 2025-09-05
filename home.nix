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
