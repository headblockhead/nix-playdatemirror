{
  description = "Mirror is an app that streams gameplay audio and video in real-time from your Playdate to a macOS, Windows, or Linux computer.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    with import nixpkgs { system = "x86_64-linux"; };
    rec {
      packages.x86_64-linux.Mirror = stdenv.mkDerivation rec {
        version = "1.3.0";
        name = "mirror-${version}";
        src = fetchurl {
          url = "https://download.panic.com/mirror/Linux/Mirror-${version}.tar.gz";
          hash = "sha256-JQNpl5UKaoEpj5wvp6k2iZ7qyKXpWiIG/z8nHt0+l38=";
        };
        nativeBuildInputs = [ autoPatchelfHook ];

        buildInputs = [
          gtk3
          webkitgtk
        ];

        installPhase = ''
          runHook preInstall
          tar xfz $src
          mkdir -p $out/bin
          cp Mirror-${version}/mirror $out/bin/mirror
          runHook postInstall
        '';

        sourceRoot = ".";
        meta = with lib; {
          homepage = "https://play.date/mirror";
          description = "Mirror streams gameplay audio and video in real-time from your Playdate to a computer";
          platforms = platforms.linux;
        };
      };
      packages.x86_64-linux.default = packages.x86_64-linux.Mirror;
    };
}
