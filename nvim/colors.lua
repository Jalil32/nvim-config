          require("onedark").setup{
            transparent = true,     -- Transparent background
            terminal_colors = true, -- Enable terminal colors
            styles = {
			    comments = { italic = true },
              keywords = { italic = true },
              functions = { bold = true },
              variables = {},
              sidebars = "transparent",
              floats = "transparent",
            },
          }
          vim.cmd[[colorscheme onedark]]
