{pkgs, ...}:
{
	imports = [
		./hardware.nix
	];

	home.packages = with pkgs; [
		moolight-qt	
	];
	
	networking.hostName = "laptop";
	boot.kernelPackages = pkgs.linuxPackages_zen;
	services.libinput.enable = true;
}
