{ pkgs, stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "mirror";
  version = "1.0.0";
  src = fetchurl {
    url = "https://download.panic.com/mirror/Linux/Mirror-1.0.0.tar.gz";
    sha256 = "bLFcT5Kq+4oPuyfIETxtEiIPdD0sZ5aPTq1Sj4hyTD0=";
  };
  builder = ./mirror-install.sh;
  system = builtins.currentSystem;
}

