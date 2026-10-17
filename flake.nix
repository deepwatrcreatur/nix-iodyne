{
  description = "Nix package, flake, and module for iodyne - disk IO, latency, topology, and health TUI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        iodyne = pkgs.callPackage ./package.nix { };
      in
      {
        packages = {
          default = iodyne;
          iodyne = iodyne;
        };

        apps.default = {
          type = "app";
          program = "${iodyne}/bin/iodyne";
        };
      }
    ) // {
      overlays.default = final: prev: {
        iodyne = self.packages.${prev.stdenv.hostPlatform.system}.iodyne;
      };

      homeManagerModules = {
        default = self.homeManagerModules.iodyne;
        iodyne = import ./modules/home-manager.nix self;
      };

      nixosModules = {
        default = self.nixosModules.iodyne;
        iodyne = import ./modules/nixos.nix self;
      };
    };
}
