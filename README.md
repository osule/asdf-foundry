# asdf-foundry

[![Build](https://github.com/yourusername/asdf-foundry/workflows/Build/badge.svg)](https://github.com/yourusername/asdf-foundry/actions)

[Foundry](https://github.com/foundry-rs/foundry) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Dependencies

- `bash`, `curl`, `tar`, `git`: generic POSIX utilities
- macOS: `make`, `gcc` or `clang` (for compiling libusb dependency)

## Install

### Plugin

```shell
asdf plugin add foundry https://github.com/yourusername/asdf-foundry.git
```

### Foundry

```shell
# Show all installable versions
asdf list-all foundry

# Install specific version
asdf install foundry nightly

# Install latest stable version
asdf install foundry latest

# Set a version globally (in your ~/.tool-versions file)
asdf set -u foundry nightly

# Set a version locally (in your current directory)
asdf set foundry nightly
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to install & manage versions.

## Usage

Once installed, you'll have access to all Foundry tools:

```shell
forge --version
cast --version
anvil --version
chisel --version
```

### macOS libusb Dependency

On macOS, Foundry's `forge` requires libusb. This plugin automatically:
- Compiles libusb from source if not present
- Creates a symlink at `/usr/local/opt/libusb/lib` where forge expects it
- Cleans up the symlink when uninstalling

No manual intervention required!

## Contributing

Contributions welcome! Read the [contributing guide](CONTRIBUTING.md) for details.

## License

See [LICENSE](LICENSE) © Oluwafemi Sule

## Acknowledgments

This plugin would not be possible without the foundational work of:

- [Foundry](https://github.com/foundry-rs/foundry) - The blazing fast Ethereum development toolkit this plugin installs
- [asdf](https://github.com/asdf-vm/asdf) - The extensible version manager that makes this plugin possible
- [libusb](https://github.com/libusb/libusb) - The USB library that Foundry depends on

Special thanks to the maintainers and contributors of these projects for their excellent work.
