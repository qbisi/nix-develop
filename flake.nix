{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "/home/qbisi/nixpkgs";
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
        ./python
      ];
      perSystem =
        { config, pkgs, ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;

          devShells =
            let
              linux-version = pkgs.runCommand "nixos-linux-version" { } ''
                mkdir -p $out
                install -Dm 555 ${./bash/linux-version} $out/bin/linux-version
              '';
            in
            {
              armbian-build = pkgs.mkShell {
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
