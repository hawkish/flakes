{
  description = "Go dev environment";

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
            pkgs.go

            # Go language server and core tools
            pkgs.gopls  # Language server with LSP support
            pkgs.gotools  # Includes goimports
            pkgs.go-tools  # Additional staticcheck analyzers

            # Optional development tools
            pkgs.golangci-lint  # Fast linter runner
            pkgs.delve  # Debugger
          ];

          shellHook = ''
            echo "Go development environment loaded"
            echo "Go version: $(go version)"
            echo "Tools available: gopls, golangci-lint, delve"

            if [ -f "go.mod" ]; then
                echo "Go module detected"
                if [ ! -d "vendor" ]; then
                    echo "Downloading Go dependencies..."
                    go mod download
                fi
            fi
          '';
        };
      }
    );
}
