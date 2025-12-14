{ pkgs, inputs, ... }: {
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

  programs.git.ignores = [ ".lexical" ".elixir-ls" ".expert" ".next-ls" ".elixir-tools" ];

  home.packages = with pkgs; [
    postgresql_16
    beam.packages.erlang_27.elixir_1_19
    inputs.expert.packages.${pkgs.stdenv.hostPlatform.system}.default
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
