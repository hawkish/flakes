{
  description = "Python 3 dev environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.zsh
            (pkgs.python3.withPackages (python-pkgs: [
              # Add your project dependencies here
              python-pkgs.pandas
              python-pkgs.requests

              # Development tools
              python-pkgs.pytest
              python-pkgs.pytest-cov
            ]))

            # Modern Python tooling (2025-2026)
            pkgs.pyright  # Type checker
            pkgs.ruff  # Fast linter and formatter (replaces flake8, black, isort)
          ];

          shellHook = ''
            echo "Python development environment loaded"
            echo "Python version: $(python --version)"
            echo "Tools available: pyright, ruff, pytest"

            # Create virtual environment if it doesn't exist
            if [ ! -d ".venv" ]; then
              echo "Creating virtual environment..."
              python -m venv .venv
            fi
          '';
        };
      }
    );
}
