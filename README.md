# Jalil's Neovim Configuration

This repository contains my personal Neovim configuration packaged as a Nix flake for easy distribution and installation.

## Features

- Full LSP integration with nixd, biome, and gopls
- Telescope fuzzy finder
- Harpoon for quick file navigation
- OneDark theme with custom transparency settings
- Git integration with fugitive
- Lualine status bar
- Custom formatting with null-ls
- Treesitter syntax highlighting for all languages

## Prerequisites: Installing Nix

Before you can use this configuration, you need to have Nix installed with flakes enabled.

### Linux and macOS

1. **Install Nix**:
   ```bash
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. **Enable Flakes** (edit `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`):
   ```
   experimental-features = nix-command flakes
   ```

3. **Restart the Nix daemon** (on Linux):
   ```bash
   sudo systemctl restart nix-daemon
   ```

### NixOS

If you're using NixOS, add the following to your `configuration.nix`:

```nix
{ pkgs, ... }: {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "your-username" ];
    };
  };
}
```

Then rebuild your system:
```bash
sudo nixos-rebuild switch
```

### Windows (via WSL2)

1. **Install WSL2** following [Microsoft's instructions](https://learn.microsoft.com/en-us/windows/wsl/install)
2. **Install a Linux distribution** (Ubuntu recommended)
3. **Inside WSL2**, follow the Linux installation steps above

## Usage

### Direct Usage

You can run this Neovim configuration directly without installing:

```bash
nix run github:jalil32/nvim-config
```

### Development Shell

To try out the configuration in a development shell:

```bash
nix develop github:jalil32/nvim-config
```

### Installing in your system

#### NixOS Configuration

Add this to your `configuration.nix`:

```nix
{
  inputs.nvim-config.url = "github:jalil32/nvim-config";
  
  outputs = { self, nixpkgs, nvim-config, ... }: {
    nixosConfigurations.yourHostname = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = [
            nvim-config.packages.${pkgs.system}.default
          ];
        })
      ];
    };
  };
}
```

#### Home Manager Integration

Add this to your Home Manager configuration:

```nix
{
  inputs.nvim-config.url = "github:jalil32/nvim-config";
  
  outputs = { self, nixpkgs, home-manager, nvim-config, ... }: {
    homeConfigurations.yourUsername = home-manager.lib.homeManagerConfiguration {
      # ...
      modules = [
        {
          home.packages = [
            nvim-config.packages.${pkgs.system}.default
          ];
        }
      ];
    };
  };
}
```

### Using as an overlay

```nix
{
  inputs.nvim-config.url = "github:jalil32/nvim-config";
  
  outputs = { self, nixpkgs, nvim-config, ... }:
    let
      overlays = [ nvim-config.overlays.default ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
    in {
      # Now you can use pkgs.jalilNeovim
    };
}
```

## Troubleshooting

### Common Issues

1. **"error: experimental feature 'nix-command' is disabled"**:
   - Ensure you have enabled experimental features as described in the installation section

2. **"error: experimental feature 'flakes' is disabled"**:
   - Same as above - check your Nix configuration 

3. **Missing dependencies**:
   - The flake should include all necessary dependencies, but if you encounter issues, try running:
     ```bash
     nix shell nixpkgs#neovim nixpkgs#gopls nixpkgs#biome
     ```

### Getting Help

If you encounter issues:
1. Check the [Nix manual](https://nixos.org/manual/nix/stable/)
2. Visit the [NixOS Discourse](https://discourse.nixos.org/)
3. Open an issue in this repository

## License

MIT
