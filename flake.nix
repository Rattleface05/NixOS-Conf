{
description = "NixOS configuration with CachyOS kernel";

inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
 	kwin-effects-better-blur-dx = {
      		url = "github:xarblu/kwin-effects-better-blur-dx";
      		inputs.nixpkgs.follows = "nixpkgs";
    	};

	nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";


};

outputs = { self, nixpkgs, nix-cachyos-kernel, ... }@inputs: {

#environment.systemPackages = [
#    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default # Wayland
#    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.x11 # X11
#  ];

nixosConfigurations.pizda = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	
	specialArgs = {inherit inputs;};

  modules = [
    # Your normal NixOS configuration
    ./configuration.nix

    # CachyOS kernel overlay
    {
      nixpkgs.overlays = [
        # Uses the exact nixpkgs revision expected by the
        # nix-cachyos-kernel binary cache.
        nix-cachyos-kernel.overlays.pinned
      ];
    }
  ];
};


};


}


