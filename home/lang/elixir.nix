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
    beam.packages.erlang_27.elixir_1_16
    lexical
    flyctl
  ];

  programs.zsh.shellAliases = {
    ids = "iex --dbg pry -S mix phx.server";
    ips = "iex -S mix phx.server";
    mdg = "mix deps.get";
    mem = "mix ecto.migrate";
  };
}
