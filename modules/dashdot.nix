{ ... }:
{
  virtualisation.oci-containers.containers.dashdot = {
    image = "mauricenino/dashdot:latest";
    ports = [ "3001:3001" ];
    volumes = [
      "/:/mnt/host:ro"
    ];
    environment = {
      DASHDOT_ENABLE_CPU_TEMPS = "true";
      DASHDOT_OVERRIDE_OS = "NixOS"; 
    };
    extraOptions = [ "--privileged" ]; 
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}
