{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      version = "1.3.274";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      rec {
        packages.${system}.default = pkgs.appimageTools.wrapType2 {
          name = "ryubing";
          version = "${version}";
          pname = "ryubing";
          src = pkgs.fetchurl {
            url = "https://git.ryujinx.app/Ryubing/Canary/releases/download/${version}/ryujinx-canary-${version}-x64.AppImage";
            hash = "sha256-bCmqYv2tCnF9oVlnTulArfcPm2yrZntWMjJcz1pe96U=";
          };
          extraPkgs = pkgs: with pkgs; [ icu ];
        };
        apps.${system}.default = {
          type = "app";
          program = "${packages.${system}.default}/bin/ryubing";
        };
      };
}
