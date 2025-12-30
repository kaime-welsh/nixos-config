{ config, pkgs, ...}:
{
  imports = [ ./hardware.nix ];

  networking.hostName = "desktop";
  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };    
}
