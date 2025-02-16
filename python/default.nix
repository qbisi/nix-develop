{ inputs, self, ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  perSystem =
    { config
    , pkgs
    , lib
    , system
    , ...
    }: {
      devShells = {
        petsc4py = pkgs.mkShell
          {
            packages = [
              (pkgs.python3.withPackages (ps: with ps; [
                petsc4py
                # config.legacyPackages.firedrake.firedrake
              ]))
            ];
          };
        firedrake = pkgs.mkShell
          {
            packages = [
              (pkgs.python3.withPackages (ps: with ps; [
                config.legacyPackages.firedrakeProject.firedrake
              ]))
            ];
          };
      };
      legacyPackages = import ./top-level.nix {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };
    };
}
