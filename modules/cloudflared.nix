{ ... }:
{
  services.cloudflared  = {
    enable = true;
    tunnels = {
      "homelab-relay" = {
        credentialsFile = "/var/lib/cloudflared/homelab-relay.json";
        default = "http://localhost:80";
      };
    };
  };
}
