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
            pkgs.zsh
            pkgs.go

            # Go tools
            pkgs.gopls
            pkgs.gotools
            pkgs.go-tools
          ];

          shellHook = ''
            if [ -f "go.mod" ] && [ ! -d "vendor" ]; then
                echo "Downloading Go dependencies..."
                go mod download
            fi
          '';
        };
      }
    );
}
