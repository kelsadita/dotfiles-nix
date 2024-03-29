{
  description = "Kelshus Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";


    # Manages confis links things in your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Kalpeshs-MacBook-Air
    darwinConfigurations."Kalpeshs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [

        ./modules/darwin
        {
            _module.args = { inherit self; };
        }

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kelsadita.imports = [
            ./modules/home-manager
          ];
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Kalpeshs-MacBook-Air".pkgs;
  };
}
