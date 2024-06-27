{
  description = "leetcode.nvim dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, flake-utils, nixvim }:
    with flake-utils.lib;
    eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./leetcode.nix; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          # extraSpecialArgs = { };
        };
        nvim = nixvim'.makeNixvimWithModule
          nixvimModule;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs;[ stylua ];
        };
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvim;
        };
      }
    );
}
