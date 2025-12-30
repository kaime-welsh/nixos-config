{ pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	networking.networkmanager.enable = true;
	time.timeZone = "America/Los_Angeles";
	
	services.displayManager.ly = {
		enable = true;	
		settings = {
			animation = "gameoflife";
			clock = "%a %d %b %R";
			bigclock = true;
			save = true;
			load = true;
		};
	};
	services.xserver.enable = true;
	services.displayManager.sessionPackages = [ pkgs.kdePackages.plasma-workspace ];
	services.desktopManager.plasma6.enable = true;
	
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	
	users.users.kai = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" "video" ];
	};
	
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
	};

	programs.gamemode.enable = true;

	system.stateVersion = "25.11";
}
