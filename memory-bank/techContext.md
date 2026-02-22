# Technical Context

## Stack

- **Language**: Bash (POSIX-compliant shell scripting)
- **Package Manager**: asdf (version manager framework)
- **Target Software**: Foundry (Ethereum development toolkit)

## Dependencies

### Runtime Dependencies
- `bash`: Shell interpreter
- `curl`: HTTP client for downloads
- `tar`: Archive extraction (tar.gz)
- `unzip`: Archive extraction (zip, Windows only)
- `git`: For listing remote tags

### macOS Build Dependencies
- `make`: Build automation
- `gcc` or `clang`: C compiler for libusb
- Standard build tools (autoconf, automake via Xcode Command Line Tools)

## External Resources

### Foundry
- **Repository**: https://github.com/foundry-rs/foundry
- **Releases**: https://github.com/foundry-rs/foundry/releases
- **Release Format**: `foundry_{tag}_{platform}_{arch}.{ext}`
- **Platforms**: linux, darwin, win32
- **Architectures**: amd64, arm64
- **Tools**: forge, cast, anvil, chisel

### libusb
- **Repository**: https://github.com/libusb/libusb
- **Version Used**: 1.0.27
- **Release Format**: `libusb-{version}.tar.bz2`
- **Required On**: macOS only
- **Install Location**: `{install_path}/lib`
- **Symlink Target**: `/usr/local/opt/libusb/lib`

### asdf
- **Documentation**: https://asdf-vm.com/plugins/create.html
- **Plugin Structure**: bin/ directory with lifecycle scripts
- **Environment Variables**:
  - `ASDF_INSTALL_VERSION`: Version being installed
  - `ASDF_INSTALL_TYPE`: Installation type (version/ref)
  - `ASDF_INSTALL_PATH`: Target installation directory
  - `ASDF_DOWNLOAD_PATH`: Temporary download directory

## Environment Setup

### Development
```bash
# Clone repository
git clone https://github.com/yourusername/asdf-foundry.git

# Install asdf (if not already installed)
# See: https://asdf-vm.com/guide/getting-started.html

# Link local plugin for testing
asdf plugin add foundry /path/to/asdf-foundry
```

### Testing
```bash
# List versions
asdf list-all foundry

# Install a version
asdf install foundry nightly

# Verify
forge --version

# Clean up
asdf uninstall foundry nightly
```

## Platform-Specific Notes

### macOS
- Requires Xcode Command Line Tools for libusb compilation
- libusb compiled from source on first install
- Symlink created at `/usr/local/opt/libusb/lib`

### Linux
- No additional dependencies beyond standard utilities
- Pre-built binaries work out of the box

### Windows
- Uses zip archives instead of tar.gz
- Requires unzip utility
- Not extensively tested (contributions welcome)
