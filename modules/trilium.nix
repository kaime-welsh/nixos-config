{ pkgs, ... }:
{
  services.trilium-server = {
    enable = true;
    dataDir = "/var/lib/trilium";
    package = pkgs.unstable.trilium-server;
    noAuthentication = true;
  };

  # networking.firewall.allowedTCPPorts = [ 8080 ];
}
