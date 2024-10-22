{
  description = "A disko images example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, disko, nixpkgs }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # You can get this file from here: https://github.com/nix-community/disko/blob/master/example/simple-efi.nix
        ./simple-efi.nix
        disko.nixosModules.disko
        ({ config, ... }: {
          # shut up state version warning
          system.stateVersion = config.system.nixos.version;
          # Adjust this to your liking.
          # WARNING: if you set a too low value the image might be not big enough to contain the nixos installation
          disko.devices.disk.main.imageSize = "10G";
        })
      ];
    };
  };
}
