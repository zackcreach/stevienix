{...}: 
{
	programs.git = {
		enable = true;
		userName = "Zack Creach";
		userEmail = "zackcreach@gmail.com";

		signing = {
			key = "64E36B881E7F93F5";
			signByDefault = true;
		};

		ignores = [".DS_Store" "creachqueries" "creachpad*"];

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
			commit = {
				verbose = true;
				template = "~/.config/git/commit-template";
			};
		};
		};

		xdg.configFile."git/commit-template".text = ''
			# Title: Summary, imperative, Capital starting, don't end with period
			# No more than 50 chars. Which is less than this  |
			
			# Remember the blank between the title and body
			
			# Body: Explain *what* and *why* not *how*
			
			# Space between Body and Footer
			
			# Footer: Project metadata (area, ticket hash, related)
			
			# Great example commit
			# Capitalized, short (50 chars or less) summary
			# 
			# More detailed explanatory text, if necessary.  Wrap it to about 72
			# characters or so.  In some contexts, the first line is treated as the
			# subject of an email and the rest of the text as the body.  The blank
			# line separating the summary from the body is critical (unless you omit
			# the body entirely); tools like rebase can get confused if you run the
			# two together.
			# 
			# Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
			# or "Fixes bug."  This convention matches up with commit messages generated
			# by commands like git merge and git revert.
			# 
			# Further paragraphs come after blank lines.
			# 
			# - Bullet points are okay, too
			# 
			# - Typically a hyphen or asterisk is used for the bullet, followed by a
			#   single space, with blank lines in between, but conventions vary here
			# 
			# - Use a hanging indent
			# 
			# If you use an issue tracker, add a reference(s) to them at the bottom,
			# like so:
			# 
			# Resolves: #123'';
	}
