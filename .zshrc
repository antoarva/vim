#use vim in zsh
bindkey -v
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
export EDITOR=vim
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--preview "head -100 {}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# alias
alias ll='ls -lG'

autoload -Uz vcs_info
setopt prompt_subst

precmd() {
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # vcs_info found something (the documentation got that backwards
        # STATUS line taken from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            PROMPT='%F{green}%n%F{orange}@%F{yellow}%m:%F{7}%3~%f %F{red}${vcs_info_msg_0_} %f%# '
        else
            PROMPT='%F{green}%n%F{orange}@%F{yellow}%m:%F{7}%3~%f %F{green}${vcs_info_msg_0_} %f%# '
        fi
    else
        # nothing from vcs_info
        PROMPT='%F{green}%n%F{orange}@%F{yellow}%m:%F{7}%3~%f %# '
    fi
}
