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
            pkgs.nodejs_22  # Use nodejs_23 or nodejs_24 when available for latest LTS

            # Package managers - uncomment the one you want to use
            # pkgs.yarn
            # pkgs.pnpm
            # pkgs.bun

            # Development tools
            pkgs.typescript
            pkgs.typescript-language-server
            pkgs.prettier
            pkgs.eslint          ];

          shellHook = ''
            echo "Node.js development environment loaded"
            echo "Node version: $(node --version)"
            echo "npm version: $(npm --version)"
            if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
                echo "Installing npm dependencies..."
                npm install
            fi
          '';
        };
      }
    );
}
