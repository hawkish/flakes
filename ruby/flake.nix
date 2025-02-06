{
  description = "Ruby environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        gems = pkgs.bundlerEnv {
          name = "gems";
          ruby = pkgs.ruby;
          gemfile = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset = ./gemset.nix;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            gems
            bundix
          ];
        };

        packages.default = stdenv.mkDerivation {
          name = "Cooking";
          src = self;
          buildInputs = [ gems ];
          buildPhase = ''
            ${gems}/bin/jekyll build
          '';
          installPhase = ''
            mkdir -p $out
            cp -r _site $out/_site
          '';
        };
      }
    );
}
