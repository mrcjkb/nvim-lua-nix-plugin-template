{
  description = "Neovim Nix flake CI template for GitHub Actions"; # TODO: Set description

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neodev-nvim = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };

    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    pre-commit-hooks,
    neovim-nightly-overlay,
    neodev-nvim,
    plenary-nvim,
    ...
  }: let
    name = "plugin-template.nvim"; # TODO: Choose a name

    plugin-overlay = import ./nix/plugin-overlay.nix {
      inherit name self;
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem = {
        config,
        self',
        inputs',
        system,
        ...
      }: let
        ci-overlay = import ./nix/ci-overlay.nix {
          inherit
            self
            neodev-nvim
            plenary-nvim
            ;
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ci-overlay
            neovim-nightly-overlay.overlay
            plugin-overlay
          ];
        };

        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks = {
            alejandra.enable = true;
            stylua.enable = true;
            luacheck.enable = true;
            lua-ls.enable = true;
            editorconfig-checker.enable = true;
            markdownlint.enable = true;
          };
          settings = {
            lua-ls = {
              config = {
                runtime.version = "LuaJIT";
                Lua = {
                  workspace = {
                    library = [
                      "${pkgs.neovim-nightly}/share/nvim/runtime/lua"
                      "${pkgs.neodev-plugin}/types/nightly"
                      "${pkgs.plenary-plugin}/lua"
                    ];
                    checkThirdParty = false;
                    ignoreDir = [
                      ".git"
                      ".github"
                      ".direnv"
                      "result"
                      "nix"
                      "doc"
                    ];
                  };
                  diagnostics.libraryFiles = "Disable";
                };
              };
            };
          };
        };

        devShell = pkgs.mkShell {
          name = "devShell"; # TODO: Choose a name
          inherit (pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            zlib
          ];
        };
      in {
        devShells = {
          default = devShell;
          inherit devShell;
        };

        packages = rec {
          default = nvim-plugin;
          inherit (pkgs) nvim-plugin;
        };

        checks = {
          formatting = pre-commit-check;
          inherit
            (pkgs)
            nvim-stable-tests
            nvim-nightly-tests
            ;
        };
      };
      flake = {
        overlays.default = plugin-overlay;
      };
    };
}
