{
  description = "Dev shell for haskell with cabal";

  inputs = {
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      pre-commit-hooks,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        packageName = "servant-template";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        defaultPackage = self.packages.${system}.${packageName};
        packages.${packageName} = pkgs.haskellPackages.callCabal2nix packageName self { };

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              hlint.enable = true;
              ormolu.enable = true;
              nixpkgs-fmt.enable = true;
            };
          };
        };

        devShells.default = pkgs.haskellPackages.shellFor {
          shellHook = ''
            SESSION_NAME="haskell-dev"

            # Run pre-commit-check shellHook
            ${self.checks.${system}.pre-commit-check.shellHook or ""}

            # Tmux session setup
            if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
              tmux new-session -d -s $SESSION_NAME -n editor
              tmux send-keys "nvim ." C-m
              tmux split-window -h
              tmux send-keys "ghcid --command='cabal repl'" C-m
              tmux split-window -v
              tmux send-keys "cabal build" C-m
              tmux select-pane -t 0
            fi

            tmux attach-session -t $SESSION_NAME
          '';

          packages = p: [ self.packages.${system}.${packageName} ];

          buildInputs = with pkgs; [
            haskellPackages.cabal-install
            haskellPackages.ghcid
            haskellPackages.ormolu
            tmux
          ];
        };
      }
    );
}
