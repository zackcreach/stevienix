{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zack Creach";
    userEmail = "zackcreach@gmail.com";

    signing = {
      signByDefault = true;
      key = "0x8C49CF77E85B9AE8";
    };

    ignores = [
      ".DS_Store"
      "creachignore"
      ".direnv/*"
      ".envrc"
      ".claude"
    ];

    aliases = {
      aa = "add .";
      brD = "branch -D";
      brc = "!git rev-parse --abbrev-ref HEAD | pbcopy";
      brd = "branch -d";
      brn = "!git rev-parse --abbrev-ref HEAD";
      cm = "commit -m";
      co = "checkout";
      coa = "checkout .";
      cob = "checkout -b";
      com = "checkout main";
      fm = "fetch origin main:main";
      mm = "merge main";
      pf = "push --force-with-lease";
      pr = "!gh pr create -w";
      rs = "reset";
      rsa = "reset .";
      s = "status";
      sp = "stash pop";
      st = "stash --include-untracked";
      su = "!git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`";
      sync = "!git fetch origin main:main && git rebase main";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        decoration = {
          light = false;
          syntax-theme = "base16-256";
          minus-style = "auto #411E35";
          plus-style = "auto #133246";
        };
      };
    };

    extraConfig = {
      blame = { date = "relative"; };
      commit = { verbose = true; template = "~/.config/git/commit-template"; };
      core = { autocrlf = "input"; };
      diff = { algorithm = "histogram"; };
      init = { defaultBranch = "main"; };
      merge = { conflictStyle = "diff3"; };
      pull = { default = "current"; rebase = true; };
      push = { default = "current"; autoSetupRemote = true; };
      rebase = { autosquash = true; };
      rerere = { enabled = true; };
    };
  };

  programs.gh.enable = true;

  xdg.configFile."git/commit-template".source = ./commit-template;
}
