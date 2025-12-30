{pkgs, ...}:
{
	imports = [
		./hardware.nix
	];
	
	networking.hostName = "laptop";
	boot.kernelPackages = pkgs.linuxPackages_zen;
	services.libinput.enable = true;
}
