{ ... }:
{
  services.crowdsec = {
    enable = true;

    localConfig.acquisitions = [
      {
        api.server.enable = true;
        api.server.listen_uri = "127.0.0.1:8080";
        db_config = {
          type = "sqlite";
          db_path = "/var/lib/crowdsec/data/crowdsec.db";
        };
        source = "journalctl";
        journalctl_filter = [ "_SYSTEMD_UNIT=caddy.service" ];
        labels.type = "caddy";
      }
    ];
  };

  services.crowdsec-firewall-bouncer = {
    enable = true;
    settings.api_url = "http://127.0.0.1:8080";
  };
}
