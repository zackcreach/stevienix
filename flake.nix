{
  description = "Cool Beans";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nix-darwin
    , home-manager
    , nixpkgs
    , NixOS-WSL
    , ...
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
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
        specialArgs = { inherit inputs self; };
      };

      nixosConfigurations.nixos-wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # pass custom arguments into sub module.
        modules = [
          ./hosts/nixos-wsl
          NixOS-WSL.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zack = import ./home/nixos-wsl.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Zacks-MacBook-Pro".pkgs;

      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              neovim
              git
              networkmanager
              gptfdisk
            ];

            systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
            users.users.root.openssh.authorizedKeys.keys = [
              "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjV8sPKVLfZWddqPBv9jfVuLlUYP0PLr+lXvbKoPLe8xX5Nt5Ch0T9GW6D5szQBsZHwQY6OUhhBuAQqcJFXGJjolvVdeTA82N5Wg/DZVG8gS8eAkiQbkj6f6hm4rMie7BUm0HYdZUodygtQFoISQb3G5Tw8KfbWfZHojT1Pdgrof5M2zLewMzBiWmL1iB3IkzMlirltHITe9ukzKqeM/InVecSUJ8BmNiflsF3TXtbLxQGsTLRE1mG50rsUonZogxzGDaKlHEd4raeM1kleyrSpwFGJJGQYz7jckwP0z/VlJeZ0/DYVT/tm8GzRlPknx1d2cCMFaeqqAk4IXcBS2ooYBdn7jQm0/GvAY6no+Cp1NiYoVDegCL2af2EthMNhrgaIvWWEIZXjEqcsjjOSAaoG551yb344+HQVesteg9Gx7+uyAbvMBLko5pC49rV99czPC3btDCLX0z5DhAh4eP0wbMrkutjFmNRe07F5NAeROLJZK5g7lrm76DCZ/lZwBc= zackcreach@gmail.com"
            ];
          })
        ];
      };
    };
}
