{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.kitty.enable = true;
  
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    ];

    settings = {
      general = with config.colorScheme.colors; {
        "col.active_border" = "rgba(${base0E}ff) rgba(${base09}ff) 60deg";
        "col.inactive_border" = "rgba(${base00}ff)";
      };

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
    packages = with pkgs; [
      hello
      vscode
      kitty
    ];
    
    username = "lockwood";
    homeDirectory = "/home/lockwood";

    stateVersion = "25.05";
  };

}
