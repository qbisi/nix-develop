{ newScope, python3, petsc }:

let
  # _petsc = (petsc.override {
  #   petsc-optimized = true;
  #   petsc-scalar-type = "real";
  #   withParmetis = true;
  #   hdf5-support = true;
  #   # petsc-withp4est = true;
  # }).overrideAttrs {
  #   doInstallCheck = false;
  # };
  callPackage = newScope firedrake;
  firedrake = rec {
    inherit callPackage;

    python = python3;
    pythonPackages = python.pkgs;
    ptscotch = callPackage ./ptscotch.nix { };
    petsc = callPackage ./petsc.nix { };

    ufl = callPackage ./ufl.nix { };
    recursivenodes = callPackage ./recursivenodes.nix { };
    fiat = callPackage ./fiat.nix { };
    tsfc_0 = callPackage ./tsfc_0.nix { };
    finat = callPackage ./finat.nix { };
    tsfc = callPackage ./tsfc.nix { };
    pyop2 = callPackage ./pyop2.nix { };
    petsc4py = callPackage ./petsc4py.nix { };
    loopy = callPackage ./loopy.nix { };
    coffee = callPackage ./coffee.nix { };
    libsupermesh = callPackage ./libsupermesh.nix { };
    firedrake = callPackage ./firedrake.nix { };
    pyadjoint = callPackage ./pyadjoint.nix { };
    checkpoint_schedules = callPackage ./checkpoint-schedules.nix { };
    irksome = callPackage ./irksome.nix { };
    pytest-mpi = callPackage ./pytest-mpi.nix { };
  };
in
firedrake
