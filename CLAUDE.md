# Claude Code Contributions

This document tracks improvements and additions made to the flakes repository.

## Recent Updates

### Go Flake
- Created new Go development flake with Go toolchain
- Added gopls (language server), gotools, and go-tools
- Added golangci-lint for comprehensive linting
- Added delve for debugging
- Enhanced shellHook with Go module detection and version info

### Clojure Flake
- Created new Clojure development flake with boot as default build tool
- Added clojure-lsp for IDE support
- Added clj-kondo for fast linting
- Added babashka for native Clojure scripting
- Auto-detects project type (boot, leiningen, deps.edn, babashka)

### Java Flake Improvements
- Upgraded from JDK 17 to JDK 21 (current LTS)
- Required minimum for jdt-language-server compatibility
- Added NIX_LD_LIBRARY_PATH for better dynamic library loading
- Added google-java-format as optional code formatting tool

### Haskell Flake Improvements
- Added haskell-language-server (HLS) for IDE support
- Explicitly added hlint to buildInputs
- Maintained existing cabal, ghcid, ormolu, and pre-commit hooks setup

### LaTeX Flake Improvements
- **Critical**: Updated from nixos-21.05 (2021) to nixos-unstable
- Added devShells.default for interactive development
- Added texlab (LaTeX language server)
- Maintains existing document build capability

### Node.js Flake Improvements
- Added prettier for code formatting
- Added eslint for linting
- Enhanced shellHook with version information
- Updated comments about future Node 24 LTS

### Python3 Flake Improvements
- Added pyright for modern type checking
- Added ruff for fast linting and formatting (replaces flake8, black, isort)
- Added pytest and pytest-cov for testing
- Enhanced shellHook with automatic virtual environment creation
- Added informative version output

### Rust Flake
- Created new Rust development flake with latest Rust toolchain
- Added rust-analyzer (language server) for IDE support
- Added clippy for linting and catching common mistakes
- Added rustfmt for code formatting
- Added cargo-watch for auto-rebuild on file changes
- Added cargo-edit for easy dependency management (cargo add/rm/upgrade)
- Enhanced shellHook with Cargo project detection and version info

### direnv Integration
- Added .envrc files to all flakes (haskell, latex, nodejs, python3, go, clojure, rust)
- Enables automatic environment loading when entering directories

## Best Practices Applied

All flakes follow modern 2025-2026 best practices:

1. **Language Servers**: Each flake includes appropriate language server (gopls, clojure-lsp, jdt-language-server, haskell-language-server, texlab, typescript-language-server, pyright, rust-analyzer)
2. **Modern Tooling**: Up-to-date tools like ruff for Python, golangci-lint for Go, clippy for Rust
3. **Informative Shell Hooks**: Version information and project detection
4. **Consistent Structure**: Using nixpkgs-unstable, flake-utils, and systems inputs
5. **direnv Support**: .envrc files for automatic environment activation

## Repository Structure

```
flakes/
├── clojure/       # Clojure with boot, clojure-lsp, clj-kondo, babashka
├── go/            # Go with gopls, golangci-lint, delve
├── haskell/       # Haskell with cabal, HLS, ghcid, ormolu
├── java/          # Java with JDK 21, jdt-language-server, gradle
├── latex/         # LaTeX with texlive, texlab
├── nodejs/        # Node.js 22 with typescript, prettier, eslint
├── python3/       # Python 3 with pyright, ruff, pytest
└── rust/          # Rust with rust-analyzer, clippy, rustfmt, cargo-watch
```

Each flake provides a complete development environment for its respective language with appropriate tooling for modern development workflows.
