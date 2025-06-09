{
  description = "Declarative user environment via nix profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # Optional dev shell
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ neovim git ];
        shellHook = ''
          echo "GenShell is up and running 󱓞 "
          export DEVENV=GenShell
        '';
      };
    }
  );
}
