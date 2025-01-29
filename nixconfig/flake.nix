{
  description = "NixOS config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # textfox = {
    #   url = "github:adriankarlen/textfox";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
   
    stylix.url = "github:danth/stylix/5ab1207b2fdeb5a022f2dd7cccf6be760f1b150f";

  };

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
      	stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
      ];
    };
  };
}

