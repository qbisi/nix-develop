{
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
                colmena
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
