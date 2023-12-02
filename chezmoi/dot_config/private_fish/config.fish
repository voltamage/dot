if status is-interactive
    # Commands to run in interactive sessions can go here
  atuin init fish | source
  starship init fish | source
end

alias c='chezmoi'
alias cat='bat -n'
alias cdif='chezmoi diff'
alias cgit='lazygit -p ~/dotfiles'
alias e='nvim'
alias en='nvim ~/.config/nvim/init.lua'
alias fd="$FZF_DEFAULT_COMMAND"
alias fetch='fastfetch -l small'
alias loc='tokei'
alias ls='eza -a -o --icons'
alias q='exit'
alias source-fish='source "$XDG_CONFIG_HOME"/fish/config.fish'
alias terraria='steam steam://rungameid/105600'
alias tree='eza -a -o --tree --icons'
alias update-termuxfont='cp /usr/share/fonts/TTF/JetBrainsMonoNerdFontMono-Medium.ttf ~/dotfiles/chezmoi/private_dot_termux/font.ttf'

function rgaf
    set RG_PREFIX 'rga --files-with-matches'
    if test (count $argv) -gt 1
        set RG_PREFIX "$RG_PREFIX $argv[1..-2]"
    end
    set -l file $file
    set file (
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[-1]'" \
        fzf --sort \
            --preview='test ! -z {} && \
                rga --pretty --context 5 {q} {}' \
            --phony -q "$argv[-1]" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window='50%:wrap'
    ) && \
    echo "opening $file" && \
    handlr open "$file"
end

function wal
	cp "$WALLPAPER"/wallpaper$argv "$WALLPAPER"/current
	nohup swaybg -m fill -i "$WALLPAPER"/current &
	sudo cp "$WALLPAPER"/current /usr/share/sddm/themes/sugar-dark/current
end

#fish_vi_key_bindings # this wipes out the custom bindings for some reason
bind \e\[B 'complete'

