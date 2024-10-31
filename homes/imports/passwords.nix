{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password
    _1password-gui
  ];

  programs.zsh.shellAliases."gpg-refresh" = "gpg-connect-agent 'scd serialno' 'learn --force' /bye";
}
