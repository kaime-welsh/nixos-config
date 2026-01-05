{
	description = "NixOS Config";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		stylix.url = "github:danth/stylix";
    wallpapers = {
	    url = "github:dharmx/walls";
	    flake = false; 
    };
	};
	
	outputs = { self, nixpkgs, nixpkgs-stable, stylix, home-manager, wallpapers, nixvim, ... }@inputs: 
	let
		system = "x86_64-linux";

		pkgs-stable = import nixpkgs-stable {
			inherit system;
			config.allowUnfree = true;
		};

		mkSystem = hostname: nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit pkgs-stable; inherit inputs; };
			modules = [
				./hosts/${hostname}/default.nix
				./common/default.nix

				stylix.nixosModules.stylix
  
				home-manager.nixosModules.home-manager {
					# home-manager.backup = true;
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit pkgs-stable; inherit inputs; };
					home-manager.users.kai = import ./common/home.nix;
				}
			];
		};
	in {
		nixosConfigurations = {
			laptop = mkSystem "laptop";
			desktop = mkSystem "desktop";
		};
	};
}
