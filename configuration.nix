
({ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  system.stateVersion = config.system.nixos.version;

  users.users.tux = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ git ];
    initialPassword = "foobar";
  };
})
