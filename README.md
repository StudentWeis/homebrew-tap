# Ropy Homebrew tap

Install the macOS clipboard manager from the official upstream release:

```sh
brew install --cask studentweis/tap/ropy
```

Apple Silicon and Intel Macs use their respective DMGs. Upgrade with
`brew upgrade --cask ropy`; Ropy's own installer is disabled for Cask installs.
Uninstall with `brew uninstall --cask ropy`. Clipboard history and preferences
are preserved.

Current releases are unsigned. At the user's request, this self-hosted Cask
automatically removes only `com.apple.quarantine` from the installed Ropy.app,
including with a custom `--appdir`. Other extended attributes are preserved;
no sudo is used. An absent attribute is harmless; other command errors stop
installation and print the error. This does not sign or notarize the application. If macOS
still blocks launch, review the source and allow Ropy in System Settings
→ Privacy & Security.

The [upstream repository](https://github.com/StudentWeis/ropy) maintains the
Cask generator and release synchronization workflow. Only stable releases with
published SHA-256 digests for both DMGs are accepted. The deploy key can write
only this tap.

## Maintenance

```sh
brew style Casks/ropy.rb
ruby -c Casks/ropy.rb
```

Before changing packaging, test installation, managed update behavior and
uninstallation in an isolated environment without overwriting an existing app.
The initial version is 0.5.7. Future synchronization begins after the upstream
Homebrew workflow is merged; it can also be dispatched manually to retry.
