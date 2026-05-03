{ self, inputs, ... }: {
  flake.nixosConfigurations.nixos-srv = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.nixos-srv-configuration
      self.nixosModules.myHomeManager
   ];
 };
}
