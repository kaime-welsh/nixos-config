{ pkgs, ... }:
{
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

      "matrix.kaiwelsh.me:80" = {
        extraConfig = ''
          log
          # Client discovery so Element knows where the homeserver is
          handle /.well-known/matrix/client {
            header Access-Control-Allow-Origin "*"
            header Content-Type "application/json"
            respond `{"m.homeserver": {"base_url": "https://matrix.kaiwelsh.me"}}`
          }

          # Proxy all Matrix API traffic to Continuwuity
          handle /_matrix/* {
            reverse_proxy 127.0.0.1:6167
          }

          # Default fallback
          handle {
            abort
          }
        '';
      };

      "http://chat.kaiwelsh.me:80" = {
        extraConfig = ''
          log
          root * ${pkgs.element-web}
          file_server
        '';
      };
    };
  };
}
