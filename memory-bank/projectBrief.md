# Project Brief: asdf-foundry Plugin

## Why This Exists

Foundry is a powerful Ethereum development toolkit, but its standard installation method (foundryup) doesn't support version management. Developers working on multiple projects often need different Foundry versions, and the unversioned installation approach makes this difficult.

This plugin brings Foundry into the asdf ecosystem, enabling:
- Version pinning per project
- Easy switching between versions
- Reproducible development environments
- Team-wide version consistency via `.tool-versions`

## Goals

1. Enable versioned installation of Foundry via asdf
2. Support all major platforms (macOS, Linux, Windows)
3. Provide a reliable alternative to the unversioned foundryup script
4. Follow asdf plugin best practices and conventions
5. Handle platform-specific dependencies automatically (libusb on macOS)

## Scope

### In Scope
- Installing Foundry from official GitHub releases
- Supporting all release types: stable, nightly, versioned releases
- Automatic libusb compilation and linking on macOS
- All four Foundry tools: forge, cast, anvil, chisel

### Out of Scope
- Building Foundry from source
- Custom Foundry builds or forks
- Attestation verification (for simplicity)
- Legacy version support (pre-release versions)

## Success Criteria

- Users can install any Foundry version with `asdf install foundry <version>`
- forge works on macOS without manual libusb setup
- Plugin follows asdf conventions and passes community standards
- Clear documentation for installation and usage
