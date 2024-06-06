{pkgs, ...}: {
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

  programs.git.ignores = [".lexical" "creachpad.ex" ".elixir-ls"];

  home.packages = with pkgs; [
    postgresql
    elixir_1_16
    erlang_27
  ];
}
