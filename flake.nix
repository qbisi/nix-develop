{
  nixConfig = {
    extra-substituters = [
      "https://colmena.cachix.org"
    ];
    extra-trusted-public-keys = [
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "/home/qbisi/nixpkgs";
    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = [
        inputs.make-shell.flakeModules.default
        # ./python
      ];
      perSystem =
        {
          config,
          pkgs,
          system,
          inputs',
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
            ];
            config = {
              allowUnfree = true;
            };
          };

          formatter = pkgs.nixfmt-rfc-style;

          make-shells = {
            nixos-config = {
              packages = with pkgs; [
                agenix-cli
                inputs'.colmena.packages.colmena
              ];
            };

            tex = {
              packages = with pkgs; [
                texliveFull
                corefonts
              ];
            };

            armbian-build =
              let
                linux-version = pkgs.runCommand "nixos-linux-version" { } ''
                  mkdir -p $out
                  install -Dm 555 ${./bash/linux-version} $out/bin/linux-version
                '';
              in
              {
                packages = with pkgs; [
                  apt
                  bashInteractive
                  dialog
                  util-linux
                  psmisc
                  gnupg
                  linux-version
                  dpkg
                ];
              };
          };
        };
    };
}
