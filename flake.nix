{
  description = "Jalil's Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Define the custom Neovim package
        customNeovim = pkgs.neovim.override {
          configure = {
            initLua = pkgs.lib.readFile ./nvim/set.lua;
            packages.myPlugins = with pkgs.vimPlugins; {
              start = [
                plenary-nvim
                nvim-treesitter
                nvim-treesitter.withAllGrammars
                netrw-nvim
                lsp-zero-nvim
                nvim-cmp

                # The following plugins need their configs loaded
                (pkgs.vimUtils.buildVimPlugin {
                  name = "vim-fugitive-configured";
                  src = vim-fugitive.src;
                  configLua = builtins.readFile ./nvim/fugitive.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "lualine-configured";
                  src = lualine-nvim.src;
                  configLua = builtins.readFile ./nvim/lualine.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "harpoon-configured";
                  src = harpoon.src;
                  configLua = builtins.readFile ./nvim/harpoon.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "onedark-configured";
                  src = onedark-nvim.src;
                  configLua = builtins.readFile ./nvim/colors.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "telescope-configured";
                  src = telescope-nvim.src;
                  configLua = builtins.readFile ./nvim/telescope.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "lspconfig-configured";
                  src = nvim-lspconfig.src;
                  configLua = builtins.readFile ./nvim/lsp.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "devicons-configured";
                  src = nvim-web-devicons.src;
                  configLua = builtins.readFile ./nvim/devicons.lua;
                })

                (pkgs.vimUtils.buildVimPlugin {
                  name = "null-ls-configured";
                  src = null-ls-nvim.src;
                  configLua = builtins.readFile ./nvim/formatters.lua;
                })
              ];
            };
          };
        };

        # Create a shell with the neovim configuration
        neovimShell = pkgs.mkShell {
          buildInputs = [
            customNeovim

            # Include necessary LSP and tools
            pkgs.nixd
            pkgs.biome
            pkgs.gopls
            pkgs.nixfmt-classic
            pkgs.stylua
          ];
        };

      in {
        packages = { default = customNeovim; };

        apps = {
          default = {
            type = "app";
            program = "${customNeovim}/bin/nvim";
          };
        };

        devShells = { default = neovimShell; };

        # Overlay to make your Neovim available in other flakes
        overlays.default = final: prev: { jalilNeovim = customNeovim; };
      });
}
