{ pkgs, ... }:
let
  callPackage = pkgs.newScope legacyPackages;
  legacyPackages = rec {
    inherit callPackage;
    firedrakeProject = callPackage ./firedrake {
      pythonPackages = pkgs.python312Packages;
    };
    # firedrake-env = (
    #   (pkgs.python3.withPackages (
    #     python-pkgs: with python-pkgs; [
    #       firedrake.firedrake
    #       matplotlib
    #     ]
    #   )).override
    #     {
    #       makeWrapperArgs = [
    #         "--set PETSC_DIR ${firedrake.petsc}"
    #         "--set OMP_NUM_THREADS 1"
    #       ];
    #       postBuild = ''
    #         touch $out/bin/activate
    #         chmod +x $out/bin/activate
    #       '';
    #     }
    # );
  };
in
legacyPackages
