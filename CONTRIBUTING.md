# Contributing

Thanks for considering contributing to asdf-foundry!

## Development Setup

1. Fork and clone the repository
2. Install asdf: https://asdf-vm.com/guide/getting-started.html
3. Link your local plugin for testing:
   ```shell
   asdf plugin add foundry /path/to/your/asdf-foundry
   ```

## Testing Changes

Test your changes locally:

```shell
# List versions
asdf list-all foundry

# Install a version
asdf install foundry nightly

# Verify installation
forge --version

# Uninstall
asdf uninstall foundry nightly
```

## Submitting Changes

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Test thoroughly on your platform
4. Commit with clear messages
5. Push and create a pull request

## Code Style

- Follow existing bash script conventions
- Use `set -euo pipefail` for safety
- Add comments for complex logic
- Keep functions focused and minimal

## Reporting Issues

When reporting issues, include:
- Your OS and version
- asdf version: `asdf --version`
- Foundry version you're trying to install
- Full error output

## Questions?

Open an issue for discussion before starting major changes.
