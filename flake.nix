{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-cosmic = {
        url = "github:lilyinstarlight/nixos-cosmic";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager/release-25.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... }@inputs: {

    nixosConfigurations = {
        esarverthinkpad = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                {
                    nix.settings = {
                        substituters = ["https://cosmic.cachix.org/"];
                        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                    };
                }
                nixos-cosmic.nixosModules.default
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.esarver = import ./home.nix;
                }
            ];
        };
    };
  };
}
