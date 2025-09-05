{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, hyprland-plugins, ... }:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; };
  in {
    homeConfigurations.lockwood =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Make flake inputs visible inside HM modules
        extraSpecialArgs = { inherit hyprland hyprland-plugins system; };

        modules = [
          ./home.nix
        ];
      };
  };
}
