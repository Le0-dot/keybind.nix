{
  description = "Nix flake to use in conjunction with home-manager to define keybinds agnostic to window manager or desktop environment.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        homeModules.key = import ./hm { inherit (nixpkgs) lib; };
        formatter = pkgs.treefmt.withConfig {
          runtimeInputs = with pkgs; [
            nixfmt
            deadnix
            keep-sorted
          ];
          settings = pkgs.lib.importTOML ./treefmt.toml;
        };
      }
    );
}
