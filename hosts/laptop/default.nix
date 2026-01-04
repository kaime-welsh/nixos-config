{pkgs, ...}:
{
	imports = [
		./hardware.nix
	];

	environment.systemPackages = with pkgs; [
		moolight-qt	
	];
	
	networking.hostName = "laptop";
	boot.kernelPackages = pkgs.linuxPackages_zen;
	services.libinput.enable = true;
}
