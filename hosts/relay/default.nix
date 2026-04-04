{ ... }:
{
  networking.hostName = "relay";
  networking.firewall.allowedTCPPorts = [ 80 443 ]; # only expose caddy
}
