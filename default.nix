{ mkDerivation, base, bytestring, containers, Diff, directory
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
}
