{ pkgs, ... }:
let
  callPackage = pkgs.newScope legacyPackages;
  legacyPackages = rec {
    inherit callPackage;
    firedrake = callPackage ./firedrake { python3 = pkgs.python312; };
    firedrake-env = ((pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      firedrake.firedrake
      matplotlib
    ])).override
      {
        makeWrapperArgs = [
          "--set PETSC_DIR ${firedrake.petsc}"
          "--set OMP_NUM_THREADS 1"
        ];
      });
  };
in
legacyPackages
