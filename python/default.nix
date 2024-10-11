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
        default = config.devShells.python;
        python = pkgs.mkShell
          {
            packages = [
              ((pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
                # config.legacyPackages.firedrake.petsc4py
                config.legacyPackages.firedrake.firedrake
              ])).override
              { makeWrapperArgs = [ 
                "--set PETSC_DIR ${config.legacyPackages.firedrake.petsc}"
                "--set OMP_NUM_THREADS 1"
               ]; })
            ];
            # shellHook = "zsh && exit 0";
          };
      };
      legacyPackages = import ./top-level.nix {
        pkgs = import inputs.nixpkgs {
          inherit system;
          # config.allowUnfree = true;
        };
      };
    };
}
