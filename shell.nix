{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, bytestring, containers, Diff, directory
      , filepath, HUnit, mtl, old-locale, parsec, process, split, stdenv
      , time, utf8-string, xml
      }:
      mkDerivation {
        pname = "filestore";
        version = "0.6.2";
        src = ./.;
        enableSeparateDataOutput = true;
        libraryHaskellDepends = [
          base bytestring containers Diff directory filepath old-locale
          parsec process split time utf8-string xml
        ];
        testHaskellDepends = [
          base Diff directory filepath HUnit mtl time
        ];
        description = "Interface for versioning file stores";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
