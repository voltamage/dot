if status is-interactive
    # Commands to run in interactive sessions can go here
  atuin init fish | source
  starship init fish | source
end

alias LazyGit='lazygit'
alias c='chezmoi'
alias cat='bat -n'
alias cd='z'
alias cdi='zi'
alias cdiff='chezmoi diff && chezmoi git diff'
alias e='nvim'
alias en='nvim ~/.config/nvim/init.lua'
alias fd="$FZF_DEFAULT_COMMAND"
alias fetch='fastfetch -l small'
alias find="$FZF_DEFAULT_COMMAND"
alias fuz='fuzzy-search-and-edit'
alias librediff='curl -s https://raw.githubusercontent.com/yokoffing/Betterfox/main/Fastfox.js -o ~/.librewolf/main/fastfox.js && cd ~/.librewolf/main && git init && git add . && git commit -m 'sync''
alias loc='tokei'
alias ls='eza -a -o --icons'
alias lynx='lynx https://lite.duckduckgo.com/lite'
alias ps='sddm-greeter --test-mode --theme /usr/share/sddm/themes/sugar-dark'
alias q='exit'
alias source-zsh='source "$XDG_CONFIG_HOME"/zsh/.zshrc'
alias symlink='ln -s'
alias terraria='steam steam://rungameid/105600'
alias tree='eza -a -o --tree --icons'
alias update-termuxfont='cp /usr/share/fonts/TTF/JetBrainsMonoNerdFontMono-Medium.ttf ~/dotfiles/chezmoi/private_dot_termux/font.ttf'
alias wikiman='wikiman -H lynx'

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
    open "$file"
end
