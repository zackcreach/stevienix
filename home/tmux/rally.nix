{ writeShellApplication
, fd
, ripgrep
, fzf
, eza
, nnn
, smug
}: writeShellApplication {
  name = "rally";
  runtimeInputs = [ fd ripgrep fzf eza smug nnn ];
  text = ''
    _tmux_sessions() {
    	if tmux ls &> /dev/null; then
    		tmux list-sessions -F '#S' 2> /dev/null | awk '{print "\033[32m \033[0m" $0}'
    	fi
    }

    _rallypoints() {
    	for search_path in $(tr ":" " " <<< "$HOME/dev"); do
    		fd -t d -d 1 --follow --search-path "$search_path" | awk '{print "\033[34m \033[0m" $0}'
    	done
    }

    _select() {
    # TODO: Find a better way to write preview
    	fzf --accept-nth '{2}' \
    		--color=fg:#e5e9f0,fg+:#e5e9f0,bg:#2E3440,bg+:#2E3440 \
    		--color=hl:#b48dac,hl+:#b48dac,info:#b48dac,marker:#b48dac \
    		--color=prompt:#81A1C1,spinner:#b48dac,pointer:#b48dac,header:#b48dac \
    		--color=border:#67738C,label:#aeaeae,query:#d9d9d9 \
    		--border=none \
    		--border-label-pos=2 \
    		--preview-window=border-rounded \
    		--padding=1 \
    		--pointer=󰳟 \
    		--layout=reverse \
    		--info=right \
    		--input-label="<CR>  <C-e>  <C-f>  " \
    		--prompt="󰱱 " \
    		--preview 'tmux capture-pane -ep -t {2} 2> /dev/null || eza --tree --icons --level 3 --git-ignore {2}' \
    		--bind="ctrl-e:execute(nnn {2})" \
    		--bind="ctrl-x:execute(tmux kill-session -t {2})" \
    		--bind="ctrl-f:reload(fd -t d {q} ~/)" \
    		--tiebreak="end"
    }

    # TODO: Find a better way to write preview
    TARGET=$( (_tmux_sessions; _rallypoints ) | _select)
    NAME=$(basename "$TARGET")

    if tmux has-session -t "$NAME"; then
    	tmux switch -t "$NAME" 2> /dev/null || tmux attach -t "$NAME"
    elif [[ -f "$HOME/.config/smug/$NAME.yml" ]]; then
    	smug start "$NAME" -a
    else
    	smug start default name="$NAME" root="$TARGET" -a
    fi
  '';
} 
