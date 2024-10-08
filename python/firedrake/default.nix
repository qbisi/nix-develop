{ newScope, python3 }:

let
  callPackage = newScope firedrake;
  firedrake = rec {
    inherit callPackage;

    python = python3;
    pythonPackages = python.pkgs;

    # Forked and unavailable packages required by firedrake and its dependencies
    ufl = callPackage ./ufl.nix { };
    recursivenodes = callPackage ./recursivenodes.nix { };
    fiat = callPackage ./fiat.nix { };
    tsfc_0 = callPackage ./tsfc_0.nix { };
    finat = callPackage ./finat.nix { };
    tsfc = callPackage ./tsfc.nix { };
    pyop2     = callPackage ./pyop2.nix     { };
    petsc4py  = callPackage ./petsc4py.nix  { };
    loopy = callPackage ./loopy.nix { };
    coffee = callPackage ./coffee.nix { };
    libsupermesh = callPackage ./libsupermesh.nix { };
    firedrake = callPackage ./firedrake.nix { };
    # sowing    = callPackage ./sowing.nix    { };
    # metis     = callPackage ./metis.nix     { };
    # hypre     = callPackage ./hypre.nix     { };
    # parmetis  = callPackage ./parmetis.nix  { };
    # exodus    = callPackage ./exodus.nix    { };

    # # Incompatible version (something with communicator/datatype cleanup callbacks?)
    # mpi4py    = callPackage ./mpi4py.nix { };
  };
in
firedrake
