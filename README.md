## Nix flake GitHub Actions CI template

A template for setting up GitHub Actions with [Nix flakes](https://nixos.wiki/wiki/Flakes).

![Nix](https://img.shields.io/badge/nix-0175C2?style=for-the-badge&logo=NixOS&logoColor=white)

## Prerequisites

* You must have a [Cachix binary cache](https://app.cachix.org/cache) set up and the `CACHIX_AUTH_TOKEN` variable must be set.


## Setup

1. Click on [Use this template](https://github.com/MrcJkb/nix-flake-github-ci-template/generate) to start a repo based on this template. (Do _not_ fork it.)
2. Change the `name` in [`nix-build.yaml`](./.github/workflows/nix-build.yml).
3. Add the test inputs to [`flake.nix`](./flake.nix).
4. Add your tests to [`mkTest` in the `ci-overlay.nix`](./nix/ci-overlay.nix).


## Contributing

All contributions are welcome!
See [CONTRIBUTING.md](./CONTRIBUTING.md).
