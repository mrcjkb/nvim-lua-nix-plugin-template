## Nix flake GitHub Actions CI template

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![Nix](https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white)

This repository is a template for Neovim plugins written in Lua.
It is based on [`nvim-lua-plugin-template`](https://github.com/nvim-lua/nvim-lua-plugin-template),
but replaces the GitHub Actions workflow with [`nix` flakes](https://nixos.wiki/wiki/Flakes).

It also provides a template for providing a `vimPlugin` nix flake output.


## Prerequisites

* You must have a [Cachix binary cache](https://app.cachix.org/cache) set up and the `CACHIX_AUTH_TOKEN` variable must be set.


## Setup

1. Click on [Use this template](https://github.com/MrcJkb/nvim-lua-nix-plugin-template/generate) to start a repo based on this template. (Do _not_ fork it.)
2. Change the `name` in [`nix-build.yaml`](./.github/workflows/nix-build.yml).
3. Add the test inputs to [`flake.nix`](./flake.nix).
4. Update [`mkPlenaryTest` in the `ci-overlay.nix`](./nix/ci-overlay.nix).
5. Add the name of your plugin to [`flake.nix`](./flake.nix).
6. Add [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) specs to the `tests` directory.


## Contributing

All contributions are welcome!
See [CONTRIBUTING.md](./CONTRIBUTING.md).
