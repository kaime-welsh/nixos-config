{ pkgs, ... }:
{
  imports = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.sysop = {
    isNormalUser = true;
    description = "SYSOP";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnhVHVPEqucRklIjuyHxfr6+iRHQtBJ8AiROvRs0bCH sysop@uplink"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    unstable.helix
    nil
    compose2nix
    lazygit
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 22 ]; # only allow ssh over tailscale

  virtualisation.docker.enable = true;
  system.stateVersion = "25.11";
}
