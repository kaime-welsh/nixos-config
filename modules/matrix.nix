{ ... }:
{
  services.matrix-continuwuity = {
    enable = true;
    settings = {
      global = {
        server_name = "matrix.kaiwelsh.me";
        allow_registration = true;
        allow_encryption = true;
        allow_federation = false;
      };
    };
  };
}
