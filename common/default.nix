{ pkgs, inputs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	networking.networkmanager.enable = true;
	time.timeZone = "America/Los_Angeles";
	
	services.displayManager.ly = {
		enable = true;	
		settings = {
			# animation = "gameoflife";
			clock = "%a %d %b %R";
			bigclock = true;
			save = true;
			load = true;
		};
	};

	services.xserver.enable = true;
	services.displayManager.sessionPackages = [ pkgs.kdePackages.plasma-workspace ];
	services.desktopManager.plasma6.enable = true;

	hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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

	stylix.enable = true;
	stylix.image = "${inputs.wallpapers}/fauna/a_black_and_orange_drawing_of_a_bug.png";
	stylix.polarity = "dark";

	system.stateVersion = "25.11";
}
