{
  description = "Mirror is an app that streams gameplay audio and video in real-time from your Playdate to a macOS, Windows, or Linux computer.";

  outputs = { self, nixpkgs }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
    mirrorsrc = pkgs.callPackage ./mirror.nix {};
    mirrorapp = pkgs.buildFHSUserEnv {
      name = "Mirror";
      targetPkgs = pkgs:
      [
          pkgs.wrapGAppsHook
          pkgs.glib
          pkgs.gdk-pixbuf
          pkgs.cairo
          pkgs.pango
          pkgs.udev
          pkgs.alsa-lib
          pkgs.gtk3
          pkgs.webkitgtk
          pkgs.pkg-config
          mirrorsrc
          pkgs.xorg.libX11
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.libserialport
          pkgs.gnome.adwaita-icon-theme
        ];
        runScript = ''MirrorFromDownload'';
    };
    shell = pkgs.mkShell {
      shellHook = ''
        # Set the GSETTINGS_SCHEMA_DIR
        export GSETTINGS_SCHEMA_DIR=${pkgs.glib.getSchemaPath pkgs.gtk3}
        # Set the XDG_DATA_DIRS
        export XDG_DATA_DIRS=$HOME/.nix-profile/share:/usr/local/share:/usr/share
                '';
      packages = [ 
        mirrorsrc
        mirrorapp
      ];
    };
  in
  {
    packages.x86_64-linux.Mirror = mirrorapp;
    defaultPackage.x86_64-linux = shell;
  };
}
