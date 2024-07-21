{
  description = "Your new nix config";

  inputs = {
    # List the channel used for software packages
    # Hardware channel - needed for fingerprint reader on Framework 13 at least
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
    } @ inputs: let 
    inherit (self) outputs;
    in {
    overlays = import ./overlays {inherit inputs;};
   
    nixosConfigurations = {
      florence = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          # Hardware support for Framework 13 AMD model
          nixos-hardware.nixosModules.framework-13-7040-amd
          {}

          # > Our main nixos configuration file <
          ./nixos/configuration.nix
          # Home-manager related
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.grmhay = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
