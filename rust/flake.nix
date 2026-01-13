{
  description = "Rust dev environment";

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
            pkgs.rustc
            pkgs.cargo

            # Rust language server and core tools
            pkgs.rust-analyzer  # Language server with LSP support
            pkgs.clippy  # Linter for catching common mistakes
            pkgs.rustfmt  # Code formatter

            # Optional development tools
            pkgs.cargo-watch  # Auto-rebuild on file changes
            pkgs.cargo-edit  # cargo add/rm/upgrade commands
          ];

          shellHook = ''
            echo "Rust development environment loaded"
            echo "Rust version: $(rustc --version)"
            echo "Cargo version: $(cargo --version)"
            echo "Tools available: rust-analyzer, clippy, rustfmt, cargo-watch"

            if [ -f "Cargo.toml" ]; then
                echo "Cargo project detected"
                if [ ! -d "target" ]; then
                    echo "Run 'cargo build' to compile your project"
                fi
            else
                echo "No Cargo.toml found. Run 'cargo init' or 'cargo new <name>' to create a project"
            fi
          '';
        };
      }
    );
}
