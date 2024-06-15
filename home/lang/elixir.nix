{ pkgs, ... }: {
  home.sessionVariables = {
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  home.file.".iex.exs".text = ''
    IEx.configure(
            default_prompt:
              "#{IO.ANSI.magenta} #{IO.ANSI.reset}(%counter) |",
            continuation_prompt:
              "#{IO.ANSI.magenta} #{IO.ANSI.reset}(.) |"
          )
  '';

  programs.git.ignores = [ ".lexical" "creachpad.ex" ".elixir-ls" ];

  home.packages = with pkgs; [
    postgresql
    beam.packages.erlang_26.elixir_1_16
    lexical
  ];

  programs.zsh.shellAliases = {
    ips = "iex -S mix phx.server";
    mco = "mix coveralls";
    mcoh = "mix coveralls.html";
    mdl = "mix dialyzer";
    mcr = "mix credo --strict";
    mdc = "mix deps.compile";
    mdg = "mix deps.get";
    mes = "mix ecto.setup";
  };
}
