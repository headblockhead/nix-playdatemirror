# Create the standard environment.
source $stdenv/setup
# Extract the source code.
tar xvfz $src
# Create place to store the binaries.
mkdir -p $out/bin
# Copy the bin directory to the output binary directory.
cp -r Mirror-1.0.0/Mirror $out/bin/MirrorFromDownload
