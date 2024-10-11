{ lib
, fetchFromGitHub
, pythonPackages
}:

pythonPackages.buildPythonPackage rec {
  version = "1.0.3";
  name = "checkpoint_schedules";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "firedrakeproject";
    repo = "checkpoint_schedules";
    rev = "v${version}";
    sha256 = "sha256-yiuUvK0BwulMBKgBZBpdjHOZk50IzSuoxsOMFoIVuWI=";
  };

  build-system = with pythonPackages; [
    setuptools
  ];

  dependencies = [
    pythonPackages.numpy
  ];

  pythonImportsCheck = [
    "checkpoint_schedules"
  ];

  nativeCheckInputs = with pythonPackages; [ pytestCheckHook ];

  meta = with lib; {
    homepage = "https://github.com/firedrakeproject/checkpoint_schedules";
    description = "Provides schedules for step-based incremental checkpointing of the adjoints to computer models";
    license = licenses.lgpl3;
  };
}
