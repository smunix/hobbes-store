{
  description = "a basic hobbes based server";
  inputs = {
    fu.url = "github:numtide/flake-utils?branch=master";
    np.url = "github:nixos/nixpkgs?branch=master";
    ms.url = "github:morganstanley/hobbes?branch=master";
  };
  outputs = { self, fu, np, ms }:
    with fu.lib;
    with np.lib;
    eachSystem [ "x86_64-linux" ] (system:
      let
        overlays = [ mkOverlay ];
        mkOverlay = final: _:
          with final; {
            store = stdenv.mkDerivation {
              name = "store";
              version = "1.0.0";
              src = ./.;
              buildInputs = [
                ms.packages.${system}."hobbesPackages/gcc-10/llvm-12/hobbes"
              ];
              buildPhase = "c++ -O2 -o store main.C -lhobbes -lrt";
              installPhase = ''
                mkdir -pv $out/bin
                cp store $out/bin/
              '';
            };
          };
      in with (import np { inherit system overlays; }); rec {
        packages = flattenTree (recurseIntoAttrs { inherit store; });
        defaultPackage = packages.store;
      });
}
