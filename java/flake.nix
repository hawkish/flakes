{
  description = "Java dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Java 21 required by build.gradle
            temurin-bin-21

            # Build tools
            gradle

            # Utilities
            jq
          ];

          shellHook = ''
            # Java paths
            export JAVA_HOME="${pkgs.temurin-bin-21}"

            # Gradle paths
            export GRADLE_HOME="${pkgs.gradle}"

            # Use local .gradle folder instead of ~/.gradle
            export GRADLE_USER_HOME="$PWD/.gradle"
            mkdir -p "$GRADLE_USER_HOME"

            echo "🚀 tok-integrationtest development environment loaded"
            echo ""
            echo "Java:"
            echo "  JAVA_HOME=$JAVA_HOME"
            echo "  Version: $(java --version | head -1)"
            echo ""
            echo "Gradle:"
            echo "  GRADLE_HOME=$GRADLE_HOME"
            echo "  GRADLE_USER_HOME=$GRADLE_USER_HOME"
            echo "  Version: $(gradle --version | grep 'Gradle' | head -1)"
            echo ""
            echo "Run tests with:"
            echo "  export JOB_NAME=StubLoginBrowserlessTest"
            echo "  export TEST_ENVIRONMENT=dev"
            echo "  ./gradlew test -PAutotestPOC"
            echo ""
          '';
        };
      }
    );
}
