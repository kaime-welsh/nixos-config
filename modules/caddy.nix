{...}:{
  services.caddy = {
    enable = true;
    extraConfig = ''
      (auth) {
        forward_auth 127.0.0.1:9091 {
          uri /api/verify?rd=https://auth.kaiwelsh.me/
          header_up X-Forwarded-Proto https
          copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
        }
      }
    '';

    virtualHosts = {
      "trilium.kaiwelsh.me:80".extraConfig = ''
        log
        handle /assets* {
          reverse_proxy 127.0.0.1:8080
        }

        handle /share* {
          reverse_proxy 127.0.0.1:8080
        }

        handle {
          import auth
          reverse_proxy 127.0.0.1:8080
        }
      '';

      "auth.kaiwelsh.me:80".extraConfig = ''
        log
        reverse_proxy 127.0.0.1:9091 {
          header_up X-Forwarded-Proto https
        }
      '';

      "http://relay.lldap:80".extraConfig = ''
        log
        reverse_proxy 127.0.0.1:17170
      '';
    };
  };
}
