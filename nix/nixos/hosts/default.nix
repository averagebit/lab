{ inputs, outputs, vars, ... }:

{
  server = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs vars;
      system = "x86_64-linux";
      host.hostName = "server";
      networking.hostName = "server";
    };
    modules = [ ./configuration.nix ./server ];
  };
}
