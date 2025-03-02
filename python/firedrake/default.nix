{ pythonPackages, mpi }:

let
  callPackage = pythonPackages.newScope firedrakeProject;
  firedrakeProject = rec {
    # mpi = mpich;
    # decorator = pythonPackages.decorator.overrideAttrs rec {
    #   pname = "decorator";
    #   version = "4.4.2";
    #   src = pythonPackages.fetchPypi {
    #     inherit pname version;
    #     hash = "sha256-46YvBSAXJEDKDcyCN0kxk4Ljd/N/FAoLme9F/suEv+c=";
    #   };
    # };
    fenics-ufl = callPackage ./fenics-ufl.nix { };
    fenics-fiat = callPackage ./fenics-fiat.nix { };
    pyadjoint-ad = callPackage ./pyadjoint-ad.nix { };
    recursivenodes = callPackage ./recursivenodes.nix { };
    loopy = callPackage ./loopy.nix { };
    coffee = callPackage ./coffee.nix { };
    libsupermesh = callPackage ./libsupermesh.nix { };
    firedrake = callPackage ./firedrake.nix { };
    checkpoint-schedules = callPackage ./checkpoint-schedules.nix { };
    irksome = callPackage ./irksome.nix { };
    constantdict = callPackage ./constantdict.nix { };
    pylit = callPackage ./pylit.nix { };
    siphash24 = callPackage ./siphash24.nix { };
    libcsiphash = callPackage ./libcsiphash.nix { };
    libcstdaux = callPackage ./libcstdaux.nix { };
    mpi-pytest = callPackage ./mpi-pytest.nix { };
  };
in
firedrakeProject
