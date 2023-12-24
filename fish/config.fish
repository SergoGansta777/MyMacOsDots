alias nvd='/Applications/Neovide.app/Contents/MacOS/neovide'
alias ls="exa" # ls
alias ll='exa -lF --git --icons' # list, size, type, git
alias llm='exa -lGd --git --sort=modified' # long list, modified date sort
alias la='exa -lhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa -lhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1' # one column, just names
alias lt='exa --tree --level=2' # tree

export PATH="$HOME/.cargo/bin:$PATH"

function starship_transient_prompt_func
    starship module character
end
function starship_transient_rprompt_func
    starship module time
end

if status is-interactive

end
starship init fish | source
enable_transience
