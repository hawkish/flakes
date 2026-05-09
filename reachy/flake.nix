{
  description = "Reachy Mini robot SDK development environment";

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

        # reachy-mini supports Python 3.10-3.12; use 3.12
        python = pkgs.python312;

        gstreamerPackages = with pkgs.gst_all_1; [
          gstreamer
          gst-plugins-base
          gst-plugins-good
          gst-plugins-bad
          gst-plugins-ugly
          gst-libav
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages =
            [
              python
              pkgs.uv
              pkgs.git
              pkgs.git-lfs
              pkgs.pyright
              pkgs.ruff
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isLinux gstreamerPackages;

          shellHook = ''
            echo "Reachy Mini development environment loaded"
            echo "Python version: $(python --version)"
            echo "Tools available: uv, pyright, ruff, git, git-lfs"

            if [ ! -d ".venv" ]; then
              echo "Creating virtual environment and installing reachy-mini..."
              uv venv .venv --python ${python}/bin/python3
              source .venv/bin/activate
              uv pip install "reachy-mini"
            else
              source .venv/bin/activate
            fi

            echo "Reachy Mini SDK ready. Run 'uv pip install \"reachy-mini[mujoco]\"' to add simulation support."
          '';
        };
      }
    );
}
