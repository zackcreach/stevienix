{ config, pkgs, ... }:
{
	imports = [
		./git.nix
	];

	home.stateVersion = "24.05";
	programs.home-manager.enable = true;
}
