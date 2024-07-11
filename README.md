# Open Tofu Nix Flake

Build open tofu versions with nix.

This project is designed for personal use. No guarantees it will fix your use-case.
I'll do my best in accepting PRs though.

## Usage

We support usage without flake. In such cases import the [lib](./lib) directly into your expression,
pass call the function with correct `version, `hash` and `vendorHash` and you should be good to go.

Flake exposes a few pre-selected versions of Open Tofu and exposes function `mkTofu` which accepts `version`, `hash`
and `vendorHash` and could build custom versions of open tofu if you're lucky.
