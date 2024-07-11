# Open Tofu Nix Flake

Build open tofu versions with nix.

This project is designed for personal use. No guarantees it will fix your use-case.
I'll do my best in accepting PRs though.

## Usage

We support usage without flake. In such cases import the [lib](./lib) directly into your expression,
call the function with correct `version`, `hash` and `vendorHash` arguments and you should be good to go.

Flake exposes a few pre-selected versions of Open Tofu and function `mkTofu` which accepts `version`, `hash`
and `vendorHash` and could build custom versions of open tofu if you're lucky.


## Examples

```
# flake.nix using flake-utils
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    open-tofu-flake.url = "github:turboMaCk/open-tofu-flake";
    open-tofu-flake.inputs.nixpkgs.follows = "nixpkgs";
    # ....
  };

  outputs = { self, nixpkgs, flake-utils, open-tofu-flake }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ./nix/overlays) ];
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "terraform" "packer" ];
      };

      # Pick the pre-defined version
      open-tofu = open-tofu-flake.outputs.packages."${system}".open-tofu-1_6_2;

      # Pick custom version
      # open-tofu = pkgs.callPackage (open-tofu-flake.mkTofu {
      #   version = "1.7.3";
      #   hash = "sha256-xP2TvL9n1mFfk5krtOTKGL6i4e+/xGLkBsMwZXiQTok=";
      #   vendorHash = "sha256-cML742FfWFNIwGyIdRd3JWcfDlOXnJVgUXz4j5fa74Q=";
      # }) {};
    in
    {
      # ....

      # Dev shell with open tofu for our ops
      devShells = {
        default = pkgs.mkShell {
          name = "my-shell-with-open-tofu";
          buildInputs = [ open-tofu ];
        };
      };
    }
  );
}
```
