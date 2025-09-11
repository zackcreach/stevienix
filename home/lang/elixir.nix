{ pkgs, ... }: {
  home.sessionVariables = {
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  home.file.".iex.exs".text = ''
        IEx.configure(
                default_prompt:
                  "#{IO.ANSI.magenta} #{IO.ANSI.reset}(%counter) |",
                continuation_prompt:
                  "#{IO.ANSI.magenta} #{IO.ANSI.reset}(.) |",
    						inspect: [limit: :infinity, pretty: true]
              )
  '';

  programs.git.ignores = [ ".lexical" ".elixir-ls" ".expert" ];

  home.packages = with pkgs; [
    postgresql_16
    beam.packages.erlang_26.elixir_1_16
    lexical
  ];

  programs.zsh.shellAliases = {
    ids = "iex --dbg pry -S mix phx.server";
    ips = "iex -S mix phx.server";
    mdg = "mix deps.get";
    mem = "mix ecto.migrate";
    mer = "mix ecto.reset";
    ms = "mix start";
  };
}
