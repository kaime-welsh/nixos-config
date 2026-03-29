{ pkgs, ... }:
{
  services.redis.servers.authelia = {
    enable = true;
    port = 6379;
    bind = "127.0.0.1";
  };

  services.authelia.instances.main = {
    enable = true;
    package = pkgs.unstable.authelia;

    secrets = {
      jwtSecretFile = "/var/lib/authelia-main/jwt_secret";
      storageEncryptionKeyFile = "/var/lib/authelia-main/storage_key";
      sessionSecretFile = "/var/lib/authelia-main/session_secret";
      oidcIssuerPrivateKeyFile = "/var/lib/authelia-main/oidc/key.pem";
    };

    environmentVariables = {
      AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE = "/var/lib/authelia-main/ldap_password";
    };

    settings = {
      theme = "dark";
      server.address = "tcp://127.0.0.1:9091";

      authentication_backend.ldap = {
        address = "ldap://127.0.0.1:3890";
        implementation = "custom";
        base_dn = "dc=kaiwelsh,dc=me";
        additional_users_dn = "ou=people";
        users_filter = "(&(|({username_attribute}={input})({mail_attribute}={input}))(objectClass=person))";
        additional_groups_dn = "ou=groups";
        groups_filter = "(member={dn})";
        user = "uid=admin,ou=people,dc=kaiwelsh,dc=me";
        attributes = {
          username = "uid";
          display_name = "displayName";
          group_name = "cn";
        };
      };

      access_control = {
        default_policy = "deny";
        rules = [
          { domain = "auth.kaiwelsh.me"; policy = "bypass"; }
          { domain = ["trilium.kaiwelsh.me" "home.kaiwelsh.me"]; policy = "one_factor"; }
        ];
      };

      session = {
        name = "authelia_session";
        redis = { host = "127.0.0.1"; port = 6379; };
        cookies = [
          {
            domain = "kaiwelsh.me";
            authelia_url = "https://auth.kaiwelsh.me";
            default_redirection_url = "https://home.kaiwelsh.me";
          }
        ];
      };

      identity_providers.oidc = {
        clients = [
          {
            client_id = "homarr";
            client_name = "Homarr Dashboard";
            client_secret = "$argon2id$v=19$m=65536,t=3,p=4$u8ziKssBfo3MO5agxP/gkw$vBV3yFeq7B9Jtytp0XAYcEFn5jrei3PPgogz6BdVy+I";
            public = false;
            authorization_policy = "one_factor";
            redirect_uris = [
              "https://home.kaiwelsh.me/api/auth/callback/oidc"
              "http://home.kaiwelsh.me/api/auth/callback/oidc"
            ];
            scopes = [ "openid" "profile" "groups" "email" ];
            userinfo_signed_response_alg = "none";
          }
        ];
      };

      storage.local.path = "/var/lib/authelia-main/db.sqlite3";
      notifier.filesystem.filename = "/var/lib/authelia-main/emails.txt";
    };
  };
}
