{
  description = "Cool Beans";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Zacks-MacBook-Pro
    darwinConfigurations."Zacks-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/Zacks-MacBook-Pro.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zack = import ./home/Zacks-MacBook-Pro.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
      specialArgs = {inherit inputs self;};
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Zacks-MacBook-Pro".pkgs;
  };
}
