{ ... }:
{
  services.lldap = {
    enable = true;
    settings = {
      ldap_port = 3890;
      http_port = 17170;
      http_url = "https://lldap.kaiwelsh.me";
      ldap_base_dn = "dc=kaiwelsh,dc=me";
      ldap_user_dn = "admin";
      jwt_secret = "7962669000519e64038556e0bf0ed085653d63ad88e48b3620ef82269fd365a1";
    };
  };

  # networking.firewall.allowedTCPPorts = [ 3890 17170 ];
}
