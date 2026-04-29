{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      rec {
        packages.${system} = {
          ryubing = let
            version = "1.3.274";
          in pkgs.appimageTools.wrapType2 {
            name = "ryubing";
            version = "${version}";
            pname = "ryubing";
            src = pkgs.fetchurl {
              url = "https://git.ryujinx.app/Ryubing/Canary/releases/download/${version}/ryujinx-canary-${version}-x64.AppImage";
              hash = "sha256-bCmqYv2tCnF9oVlnTulArfcPm2yrZntWMjJcz1pe96U=";
            };
            extraPkgs = pkgs: with pkgs; [ icu ];
          };
          eden = let
            version = "v0.2.0-rc2";
          in pkgs.appimageTools.wrapType2 {
            name = "eden";
            version = "${version}";
            pname = "eden";
            src = pkgs.fetchurl {
              url = "https://stable.eden-emu.dev/${version}/Eden-Linux-${version}-amd64-gcc-standard.AppImage";
              hash = "sha256-1Pp6VInWYfr8f8ANuT1ZBxe61xCWcTq/mNH8T6JZJJc=";
            };
          };
        };
        apps.${system} = {
          ryubing = {
            type = "app";
            program = "${packages.${system}.ryubing}/bin/ryubing";
          };
          eden = {
            type = "app";
            program = "${packages.${system}.eden}/bin/eden";
          };
        };
      };
}
