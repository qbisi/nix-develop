{ lib, fetchFromGitHub, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  version = "20240829.0";
  name = "firedrake-loopy-${version}";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "loopy";
    rev = "Firedrake_${version}";
    sha256 = "sha256-45iq3H+HW8oMqKN6mP2abGuQ9M66yiiZHfP5VTpPJu0=";
    fetchSubmodules = true;
  };

  build-system = with pythonPackages; [ setuptools ];

  dependencies = with pythonPackages; [
    codepy
    cgen
    colorama
    genpy
    immutables
    islpy
    mako
    numpy
    pymbolic
    pyopencl
    pyrsistent
    pytools
    typing-extensions
  ];

  postConfigure = ''
    export HOME=$(mktemp -d)
  '';

  pythonImportsCheck = [ "loopy" ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/loopy";
    description = "Copy of upstream loopy for use with Firedrake.";
    license = licenses.mit;
  };
}
