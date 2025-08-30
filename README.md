# NixOS Configuration

This repository contains my personal NixOS and Darwin (macOS) configurations managed with flakes.

## Overview

This project uses [Nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager) to manage system configurations and user environments across multiple machines:

- macOS systems (`centennial` and `promenade`)
- Linux systems (WSL `tabernacle` and native `symphony`)
- Minimal installation ISO

## Flakes

The project is structured as a Nix flake with:

- **Darwin configurations**: For macOS systems
- **NixOS configurations**: For Linux systems
- **ISO configuration**: For creating minimal installation media

## Usage

### Building Darwin Configurations

```bash
# Build centennial configuration (macOS)
darwin-rebuild build --flake .#centennial

# Switch to centennial configuration
darwin-rebuild switch --flake .#centennial
```

### Building NixOS Configurations

```bash
# Build tabernacle configuration (WSL)
sudo nixos-rebuild build --flake .#tabernacle

# Switch to tabernacle configuration
sudo nixos-rebuild switch --flake .#tabernacle

# Build symphony configuration (native NixOS)
sudo nixos-rebuild build --flake .#symphony
```

### Building ISO

```bash
# Build installation ISO
nix build .#iso
```

## Structure

- `flake.nix`: Main flake file defining all configurations
- `hosts/`: Machine-specific configurations
  - `centennial/`, `promenade/`, `tabernacle/`, `symphony/`
- `home/`: User environment configurations for each host
  - `centennial.nix`, `promenade.nix`, `tabernacle.nix`, `symphony.nix`
- `editor/`: Neovim configuration and plugins
- Other directories for various system components

## Key Features

- **Consistent package management**: Uses Nix for reproducible environments
- **Separate user configurations**: Each host has its own user environment
- **Multi-platform support**: Works on macOS, Linux (WSL and native)
- **Minimal ISO**: Includes essential tools for system recovery

## Dependencies

- [Nix](https://nixos.org/) with flake support
- [darwin-rebuild](https://github.com/LnL7/nix-darwin) for macOS
- [home-manager](https://github.com/nix-community/home-manager)

## Contributing

This is a personal configuration. Feel free to fork and adapt for your own use, but it's not built to be a general-purpose template.

## License

MIT
