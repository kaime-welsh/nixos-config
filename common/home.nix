{ pkgs, pkgs-stable, osConfig, inputs, ... }:
{
	home.username = "kai";
	home.homeDirectory = "/home/kai";
	
	programs.git = {
		enable = true;
		settings = {
			user.name = "Kai";
			user.email = "kaime.r.welsh@gmail.com";
			init.defaultBranch = "main";
		};
	};

	programs.ssh = {
		enable = true;
		addKeysToAgent = "yes";

		matchBlocks = {
			"github.com" = {
				hostname = "github.com";
				user = "git";
				identityFile = "~/.ssh/id_ed25519";
			};
		};
	};
	
	programs.bash = {
		enable = true;
		shellAliases = {
			update = "sudo nixos-rebuild switch --flake ~/nixos-config#${osConfig.networking.hostName}";
		};
	};
	
	home.packages = with pkgs; [
		firefox
		neofetch

		helix
		neovim
		git
		gitui
		yazi
		zellij

		xclip
		wl-clipboard

		vesktop
		mangohud
		protonup-qt
	];

	home.stateVersion = "25.11";
}
