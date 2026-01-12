{
  description = "Clojure dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
  };
  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.zsh
            pkgs.clojure

            # Build tools - uncomment the one you want to use
            pkgs.boot  # Build tool
            # pkgs.leiningen  # Alternative build tool

            # Language server and development tools
            pkgs.clojure-lsp  # Language server with IDE support
            pkgs.clj-kondo  # Fast Clojure linter
            pkgs.babashka  # Native Clojure scripting
          ];

          shellHook = ''
            echo "Clojure development environment loaded"
            echo "Clojure version: $(clojure --version 2>&1 | head -n 1)"
            echo "Boot version: $(boot -V 2>&1 | head -n 1)"
            echo "Tools available: clojure-lsp, clj-kondo, babashka"

            if [ -f "build.boot" ]; then
                echo "Boot project detected (build.boot)"
            elif [ -f "project.clj" ]; then
                echo "Leiningen project detected (project.clj)"
            elif [ -f "deps.edn" ]; then
                echo "deps.edn project detected"
            elif [ -f "bb.edn" ]; then
                echo "Babashka project detected (bb.edn)"
            fi
          '';
        };
      }
    );
}
