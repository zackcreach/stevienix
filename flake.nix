{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
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
    nord-tmtheme = {
      url = "github:crabique/Nord-plist";
      flake = false;
    };
    opnix.url = "github:brizzbuzz/opnix";
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , home-manager
    , nixpkgs
    , nixpkgs-stable
    , NixOS-WSL
    , opnix
    , ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#centennial
      darwinConfigurations.centennial = nix-darwin.lib.darwinSystem {
        modules = [
          opnix.darwinModules.default
          ./hosts/centennial
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/centennial.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              pkgsStable = import nixpkgs-stable {
                system = "aarch64-darwin";
                config.allowUnfree = true;
              };
            };
          }
        ];
        specialArgs = { inherit inputs self; };
      };

      darwinConfigurations.promenade = nix-darwin.lib.darwinSystem {
        modules = [
          opnix.darwinModules.default
          ./hosts/promenade
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/promenade.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              pkgsStable = import nixpkgs-stable {
                system = "aarch64-darwin";
                config.allowUnfree = true;
              };
            };
          }
        ];
        specialArgs = { inherit inputs self; };
      };

      nixosConfigurations.tabernacle = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pass custom arguments into sub module.
        modules = [
          opnix.nixosModules.default
          ./hosts/tabernacle
          NixOS-WSL.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/tabernacle.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              pkgsStable = import nixpkgs-stable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          }
        ];
      };

      nixosConfigurations.symphony = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pass custom arguments into sub module.
        modules = [
          opnix.nixosModules.default
          ./hosts/symphony
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/symphony.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              pkgsStable = import nixpkgs-stable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
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
