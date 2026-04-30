{ self, inputs, ... }: {
  flake.nixosConfigurations.nixosSrv = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.nixosSrvConfiguration
      self.nixosModules.myHomeManager
   ];
 };
}
