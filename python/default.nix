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
              (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
                numpy
                pandas
                requests
              ]))
            ];
            # shellHook = "zsh && exit 0";
          };
      };
      legacyPackages = {
        firedrake = pkgs.callPackage ./firedrake { python3 = pkgs.python312; };
      };
    };
}
