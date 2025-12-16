# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ pkgs, ... }:

{
  imports = [ ];

  wsl = {
    enable = true;
    wslConf = {
      automount.root = "/mnt";
      network.generateHosts = false;
    };
    defaultUser = "zack";
    startMenuLaunchers = true;
  };

  users.users.zack = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    initialPassword = "password";
  };

  networking.hostName = "tabernacle";

  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}
