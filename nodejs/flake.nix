{
  description = "Nodejs dev environment";

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
            pkgs.nodejs_22

            # Comment out one of these to use an alternative package manager.
            # pkgs.yarn
            # pkgs.pnpm
            # pkgs.bun

            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.claude-code
          ];

          shellHook = ''
            if [ ! -d "node_modules" ]; then
                echo "Installing npm dependencies..."
                npm install
            fi
          '';
        };
      }
    );
}
