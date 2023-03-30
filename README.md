# Nix flake Neovim Lua plugin template

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![Nix](https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white)

This repository is a template for Neovim plugins written in Lua.

## Features

- GitHub Actions workflows with a locally reproducible CI,
  using [`nix` flakes](https://nixos.wiki/wiki/Flakes).
- Lints and a nix shell with pre-commit-hooks:
  - [`luacheck`](https://github.com/mpeterv/luacheck)
  - [`stylua`](https://github.com/JohnnyMorganz/StyLua)
  - [`alejandra`](https://github.com/kamadorueda/alejandra)
  - [`editorconfig-checker`](https://github.com/editorconfig-checker/editorconfig-checker)
  - [`markdownlint`](https://github.com/DavidAnson/markdownlint)
- `vimPlugin` nix flake output.

## Prerequisites

- You must have a [Cachix binary cache](https://app.cachix.org/cache) set up
  and the `CACHIX_AUTH_TOKEN` variable must be set.

## Setup

1. Click on [Use this template](https://github.com/MrcJkb/nvim-lua-nix-plugin-template/generate)
to start a repo based on this template. (Do _not_ fork it.)
2. Change the `name` fields in
[`nix-build.yaml`](./.github/workflows/nix-build.yml) to your cachix username.
3. If your plugin depends on other plugins,
add them as inputs to [`flake.nix`](./flake.nix).
4. Add them to [`nvim-wrapped` in the `ci-overlay.nix`](./nix/ci-overlay.nix).
5. Add the name of your plugin to [`flake.nix`](./flake.nix).
6. Add [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) specs
to the `tests` directory.

## Contributing

All contributions are welcome!
See [CONTRIBUTING.md](./CONTRIBUTING.md).
