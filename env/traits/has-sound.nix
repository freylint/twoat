{ environment, security, services, ... }:
{
  # TODO apply latency to pulse apps and deduplicate
   environment.etc = {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 48000
        default.clock.quantum = 32
        default.clock.min-quantum = 32
        default.clock.max-quantum = 32
      }
    '';
  };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
