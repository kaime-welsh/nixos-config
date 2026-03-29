{ pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
    ];

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
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    unstable.helix
    zellij
    yazi
    nil
    compose2nix
    unstable.neovim
    fzf
    ripgrep
    fd
    lazygit
    curl
    cargo
    clang
    llvm
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

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
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
}
