{
  description = "Java dev environment";

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
            pkgs.jdk21  # Updated to JDK 21 (current LTS, required for jdt-language-server)

            # Build tools - uncomment the one you want to use
            pkgs.gradle
            # pkgs.maven

            # Language server for IDE support
            pkgs.jdt-language-server

            # Optional: Code formatting and additional tools
            # pkgs.google-java-format
          ];

          shellHook = ''
            export JAVA_HOME=${pkgs.jdk21}
            export NIX_LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
              pkgs.stdenv.cc.cc
            ]}
            echo "Java development environment loaded"
            echo "JAVA_HOME: $JAVA_HOME"
            echo "Java version: $(java -version 2>&1 | head -n 1)"
            echo "Gradle version: $(gradle -version 2>&1 | grep Gradle)"
          '';
        };
      }
    );
}
