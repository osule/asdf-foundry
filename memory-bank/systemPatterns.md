# System Patterns

## Architecture Overview

This plugin follows the standard asdf plugin architecture with separated concerns for download, installation, and cleanup.

## Design Patterns

### Separation of Concerns
- `bin/download`: Fetches and extracts archives
- `bin/install`: Moves binaries and handles dependencies
- `bin/uninstall`: Cleans up symlinks and artifacts
- `lib/utils.bash`: Shared utility functions

### Platform Detection
- Runtime platform/architecture detection via `detect_platform_arch()`
- Platform-specific logic isolated to conditional blocks
- Extension handling (tar.gz vs zip) based on platform

### Dependency Management
- libusb compiled on-demand for macOS
- Symlink strategy for system-wide library access
- Cleanup on uninstall to avoid orphaned symlinks

## Key Architectural Decisions

### Why Separate bin/download and bin/install?
Follows asdf best practices. Allows asdf to cache downloads and retry installations without re-downloading.

### Why Compile libusb Instead of Using Homebrew?
- Avoids external dependency on Homebrew
- Ensures version compatibility
- Self-contained installation
- Works in environments without Homebrew

### Why Symlink to /usr/local/opt/libusb/lib?
Forge's binary is hardcoded to look for libusb at this path. Symlinking is the least invasive solution that doesn't require patching binaries.

### Version Normalization
- GitHub tags use "v" prefix for numeric versions (v1.0.0)
- Tags like "nightly" and "stable" have no prefix
- Plugin adds "v" only for numeric versions when constructing URLs

## Error Handling
- `set -euo pipefail` for fail-fast behavior
- Custom `fail()` function for consistent error messages
- Silent compilation output (redirected to /dev/null) with failure detection

## Code Conventions
- Bash scripts with strict mode
- Local variables in functions
- Descriptive variable names
- Minimal comments (code should be self-documenting)
