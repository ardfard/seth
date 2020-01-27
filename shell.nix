with import (builtins.fetchTarball {
  name = "nixos-unstable-2019-pre";
  url = https://github.com/nixos/nixpkgs/archive/c2742295fb1fd82d0adb9bc63ec79158ef85026f.tar.gz;
  sha256 = "1r60abq9pkpdf3zmwr90585z1hc4i0b2pq2fn5f5kjnxrk2q3fla";
}) {};
let 
  ruby = ruby_2_3;
  rubygems = (rubygems.override { ruby = ruby; });
in 
stdenv.mkDerivation {
  name = "seth";
  buildInputs = [
    libxml2
    ruby
    zookeeper
  ];
  shellHook = ''
    mkdir -p .nix-gems
    export GEM_HOME=$PWD/.nix-gems
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
  '';
}
