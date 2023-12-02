zoxide init fish | source

# is this redundant when compared with the aliases near the bottom
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

abbr --erase cd &>/dev/null
alias cd=__zoxide_z

abbr --erase cdi &>/dev/null
alias cdi=__zoxide_zi
