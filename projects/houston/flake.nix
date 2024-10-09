{
  description = "Houston Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (pkgs.lib) optional optionals;
        erlang_version = "27.0.1";
        elixir_version = "1.17.2";

        # nodePackages installed will use pkgs.nodejs
        # overlyaing node 18 so they are installed with correct node version
        # https://nixos.wiki/wiki/Node.js
        pkgs = import nixpkgs { inherit system; overlays = [ (final: prev: { nodejs = prev.nodejs_20; }) ]; };

        beamBuilder = pkgs.beam.packagesWith (pkgs.beam.interpreters.erlang_26.override {
          version = erlang_version;
          sha256 = "sha256-Lp6J9eq6RXDi0RRjeVO/CIa4h/m7/fwOp/y0u0sTdFQ=";
        });

        elixir = beamBuilder.elixir.override {
          version = elixir_version;
          sha256 = "sha256-8rb2f4CvJzio3QgoxvCv1iz8HooXze0tWUJ4Sc13dxg=";
        };
      in
      with pkgs;
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            # Node stuff
            nodejs
            nodePackages.typescript-language-server
            nodePackages.prettier
            # Elixir goodies
            elixir
            (lexical.override { elixir = elixir; })
            # general utils
            postgresql_14
            glibcLocales
            stripe-cli
            go-task
          ] ++ optional stdenv.isLinux inotify-tools
          ++ optional stdenv.isDarwin terminal-notifier
          ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
            CoreFoundation
            CoreServices
          ]);
        };
      });
}
