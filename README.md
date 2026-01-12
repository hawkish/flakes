# Development Environment Flakes

A collection of Nix flakes providing complete, reproducible development environments for multiple programming languages.

## Overview

This repository contains ready-to-use Nix flakes for various programming languages, each configured with modern tooling including language servers, linters, formatters, and build tools. All flakes follow 2025-2026 best practices and include direnv integration for automatic environment activation.

## Available Flakes

### Clojure
- **Build Tools**: Boot (default), Leiningen (optional)
- **Tooling**: clojure-lsp, clj-kondo, babashka
- **Features**: Auto-detects project type (boot, leiningen, deps.edn, babashka)

### Go
- **Version**: Latest Go
- **Tooling**: gopls, gotools, go-tools, golangci-lint, delve
- **Features**: Go module detection, comprehensive linting, debugging support

### Haskell
- **Build Tools**: Cabal, ghcid
- **Tooling**: haskell-language-server (HLS), hlint, ormolu
- **Features**: Pre-commit hooks, tmux integration

### Java
- **Version**: JDK 21 (current LTS)
- **Build Tools**: Gradle (default), Maven (optional)
- **Tooling**: jdt-language-server, google-java-format (optional)
- **Features**: Enhanced library loading compatibility

### LaTeX
- **Version**: nixos-unstable
- **Tooling**: texlab, latexmk, custom TeX Live package set
- **Features**: Document building and interactive development

### Node.js
- **Version**: Node.js 22
- **Package Managers**: npm (default), yarn, pnpm, bun (optional)
- **Tooling**: TypeScript, typescript-language-server, prettier, eslint
- **Features**: Auto npm install, version info

### Python 3
- **Version**: Python 3
- **Tooling**: pyright, ruff, pytest, pytest-cov
- **Features**: Virtual environment creation, modern linting/formatting

## Usage

### Quick Start

Navigate to any flake directory and run:

```bash
nix develop
```

### With direnv (Recommended)

Each flake includes a `.envrc` file for automatic environment activation:

1. Install [direnv](https://direnv.net/)
2. Navigate to a flake directory
3. Run `direnv allow`
4. The environment will activate automatically when you enter the directory

### Using in Your Projects

Copy the desired flake to your project:

```bash
cp -r /path/to/flakes/go/flake.nix your-project/
cp -r /path/to/flakes/go/.envrc your-project/
```

Then customize the flake for your project's specific needs.

## Features

All flakes include:

- **Language Servers**: Full IDE support (LSP)
- **Modern Tooling**: Up-to-date linters, formatters, and build tools
- **Informative Shell Hooks**: Version information and project detection
- **Consistent Structure**: Using nixpkgs-unstable, flake-utils
- **direnv Support**: Automatic environment activation

## Documentation

See [CLAUDE.md](CLAUDE.md) for detailed information about improvements and best practices applied to each flake.

## License

See [LICENSE](LICENSE) for details.