{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lz-n = {
      url = "github:nvim-neorocks/lz.n";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , home-manager
    , nixpkgs
    , NixOS-WSL
    , ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#centennial
      darwinConfigurations.centennial = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/centennial
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/centennial.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
        specialArgs = { inherit inputs self; };
      };

      nixosConfigurations.tabernacle = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pass custom arguments into sub module.
        modules = [
          ./hosts/tabernacle
          NixOS-WSL.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/tabernacle.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      nixosConfigurations.symphony = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pass custom arguments into sub module.
        modules = [
          ./hosts/symphony
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/symphony.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.centennial.pkgs;

      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [
                neovim
                git
                networkmanager
                gptfdisk
              ];

              systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
              users.users.root.openssh.authorizedKeys.keys = [
                # ssh-add -L
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0PMZX36AvlE6+w7TWF0Nvg4QBl6rV+xuaffQDR6Mcs cardno:26_329_662"
              ];
            }
          )
        ];
      };
    };
}
