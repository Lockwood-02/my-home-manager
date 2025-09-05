{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];
    
    username = "lockwood";
    homeDirectory = "/home/lockwood";

    stateVersion = "25.05";
  };
}
