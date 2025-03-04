{ inputs, self, ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  perSystem =
    {
      config,
      pkgs,
      lib,
      system,
      ...
    }:
    {
      devShells = {
        petsc4py = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (
              ps: with ps; [
                petsc4py
                # config.legacyPackages.firedrake.firedrake
              ]
            ))
          ];
        };
        mpi-pytest = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (
              ps: with ps; [
                config.legacyPackages.firedrakeProject.mpi-pytest
              ]
            ))
          ];
        };
        firedrake = pkgs.mkShell {
          packages = [
            (pkgs.jupyter.withPackages (
              ps:
              with ps;
              [
                config.legacyPackages.firedrakeProject.firedrake
                config.legacyPackages.firedrakeProject.siphash24
                matplotlib
                pytest
                vtk
                ipykernel
              ]
              ++ config.legacyPackages.firedrakeProject.firedrake.optional-dependencies.test
            ))
            pkgs.blas
            pkgs.lapack
          ];

          shellHook = ''
            export OMP_NUM_THREADS=1
            export VIRTUAL_ENV=$HOME
          '';
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
