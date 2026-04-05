{
  description = "Relay Server Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; 
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations.relay = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ overlay-unstable ];
          })
          ./hosts/relay/hardware-configuration.nix
          ./configuration.nix
          ./hosts/relay
          ./modules/trilium.nix
          ./modules/lldap.nix
          ./modules/authelia.nix
          ./modules/caddy.nix
          ./modules/cloudflared.nix
          # ./modules/crowdsec.nix
          # ./modules/dashdot.nix
          # ./modules/homarr/homarr.nix
          # ./modules/teamspeak/teamspeak6.nix          
        ];
      };

      nixosConfigurations.citadel = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ overlay-unstable ];
          })
          ./hosts/citadel/hardware-configuration.nix
          ./configuration.nix
          ./hosts/citadel
        ];
      };
    };
}
