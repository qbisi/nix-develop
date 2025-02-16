{ stdenv, makeShellWrapper, mpi, bubblewrap , coreCpus ? 2 }:

stdenv.mkDerivation
{
  name = "mpi-bwrapped";

  phases = [ "buildPhase" ];

  nativeBuildInputs = [ makeShellWrapper ];

  buildInputs = [ mpi bubblewrap ];

  buildPhase = ''
    install -d $out/root/{proc,dev,build,nix/store,sys/class/net}
    for i in {0..${builtins.toString coreCpus}}
    do
    install -d $out/root/sys/devices/system/cpu/cpu$i/topology
    echo $i > $out/root/sys/devices/system/cpu/cpu$i/topology/core_cpus
    done
    echo '0-${builtins.toString coreCpus}' > $out/root/sys/devices/system/cpu/possible
    makeWrapper "${bubblewrap}/bin/bwrap" "$out/bin/mpirun" --add-flags "--bind $out/root / --bind /build /build --proc /proc --dev /dev --bind /nix/store /nix/store ${mpi}/bin/mpirun --prefix ${mpi}"
    makeWrapper "${bubblewrap}/bin/bwrap" "$out/bin/mpiexec" --add-flags "--bind $out/root / --bind /build /build --proc /proc --dev /dev --bind /nix/store /nix/store ${mpi}/bin/mpiexec --prefix ${mpi}"
  '';
}
