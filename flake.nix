{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: {
    mkTofu = import ./lib;
  } // (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildTofu = args: pkgs.callPackage (import ./lib args) {};
      in {
        packages = rec {
          open-tofu-1_6_2 = buildTofu {
            version = "1.6.2";
            hash = "sha256-CYiwn2NDIAx30J8tmbrV45dbCIGoA3U+yBdMj4RX5Ho=";
            vendorHash = "sha256-kSm5RZqQRgbmPaKt5IWmuMhHwAu+oJKTX1q1lbE7hWk=";
          };
          open-tofu-1_6_3 = buildTofu {
            version = "1.6.3";
            hash = "sha256-AsqxcEzr3LUpCkB4d65GItnuipD2ECLlk+NlQN9TEt0=";
            vendorHash = "sha256-kSm5RZqQRgbmPaKt5IWmuMhHwAu+oJKTX1q1lbE7hWk";
          };
          open-tofu-1_7_3 = buildTofu {
            version = "1.7.3";
            hash = "sha256-xP2TvL9n1mFfk5krtOTKGL6i4e+/xGLkBsMwZXiQTok=";
            vendorHash = "sha256-cML742FfWFNIwGyIdRd3JWcfDlOXnJVgUXz4j5fa74Q=";
          };
          open-tofu = open-tofu-1_6_2;
          default = open-tofu;
        };
      }));
}
