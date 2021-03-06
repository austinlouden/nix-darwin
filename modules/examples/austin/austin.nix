{ config, lib, pkgs, ... }:
let
  fastarcheyosx = pkgs.callPackage ./src/fastarcheyosx/c.nix {};
  scmpuff = pkgs.callPackage ./src/scmpuff/c.nix {};
  highlight = pkgs.callPackage ./src/highlight/c.nix {};
in
{
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  imports = [
    ./src/zsh/c.nix
    ./src/vim/c.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    cmake
    fastarcheyosx
    scmpuff
    highlight
    asciinema
    fzf
    gettext
    git
    git-lfs
    ripgrep
    jq
    arcanist
    wget
    coreutils
    go
    fasd
    nix-repl
    nox
  ];

  environment.extraOutputsToInstall = [ "man" ];

  # For some reason I get nix build errors when this is enabled
  nix.requireSignedBinaryCaches = false;

  services.activate-system.enable = true;
}
