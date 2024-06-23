{ pkgs, ... }:

pkgs.writeShellScriptBin "rally" ''
  set -eu

  FZF_CONFIG='
	--color=fg:#e5e9f0,fg+:#e5e9f0,bg:#2E3440,bg+:#2E3440
  --color=hl:#b48dac,hl+:#b48dac,info:#b48dac,marker:#b48dac
  --color=prompt:#B48EAD,spinner:#b48dac,pointer:#b48dac,header:#b48dac
  --color=border:#67738C,label:#aeaeae,query:#d9d9d9
  --border=none --border-label-pos=2 --preview-window=border-rounded
  --padding=1
	--pointer=󰳟
	--layout=reverse
  --info=right
  '

  TARGET=$(ls -d ~/dev/* | ${pkgs.fzf}/bin/fzf $FZF_CONFIG --prompt="󰱱 " --preview '${pkgs.eza}/bin/eza --tree --icons --level 1 --group-directories-first --git-ignore {}')
  NAME=$(basename $TARGET)
  SESSION_NAME=$(echo $NAME | tr [:lower:] [:upper:])

  if [[ -f "$HOME/.config/smug/$NAME.yml" ]]; then
  	${pkgs.smug}/bin/smug start $NAME -a
  else
  	${pkgs.smug}/bin/smug start default name=$SESSION_NAME root=$TARGET -a
  fi
''
