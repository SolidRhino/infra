{
  description = "A flake with pre-commit hooks";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    git-hooks-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake
    {inherit inputs;}
    {
      imports = [
        inputs.git-hooks-nix.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        pre-commit.settings.hooks = {
          ansible-lint.enable = true;
          alejandra.enable = true;
          ripsecrets.enable = true;
        };
        # NOTE: You can also use `config.pre-commit.devShell`
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ansible
            ansible-lint
            just

            ripsecrets
            alejandra
          ];

          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
      };
    };
}
