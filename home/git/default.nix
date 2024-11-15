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
    ];

    aliases = {
      su = "!git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`";
      s = "status";
      co = "checkout";
      coa = "checkout .";
      cob = "checkout -b";
      rs = "reset";
      rsa = "reset .";
      com = "checkout main";
      brc = "!git rev-parse --abbrev-ref HEAD | pbcopy";
      brn = "!git rev-parse --abbrev-ref HEAD";
      brd = "branch -d";
      brD = "branch -D";
      cm = "commit -m";
      aa = "add .";
      st = "stash --include-untracked";
      sp = "stash pop";
      fm = "fetch origin main:main";
      mm = "merge main";
      pf = "push --force-with-lease";
      pr = "!gh pr create -w";
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
      init = { defaultBranch = "main"; };
      push = { default = "current"; autoSetupRemote = true; };
      pull = { default = "current"; };
      diff = { algorithm = "histogram"; };
      blame = { date = "relative"; };
      rebase = { autosquash = true; };
      merge = { conflictStyle = "diff3"; };
      core = { autocrlf = "input"; };
      commit = {
        verbose = true;
        template = "~/.config/git/commit-template";
      };
    };
  };

  programs.gh.enable = true;

  xdg.configFile."git/commit-template".source = ./commit-template;
}
