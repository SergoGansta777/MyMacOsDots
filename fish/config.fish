export PATH="$HOME/.cargo/bin:$PATH"

set -gx EDITOR nvim
set -gx PF_INFO "ascii title os uptime pkgs wm shell editor"

alias nvd='/Applications/Neovide.app/Contents/MacOS/neovide'
alias ls="exa" # ls
alias ll='exa -lF --git --icons' # list, size, type, git
alias llm='exa -lGd --git --sort=modified' # long list, modified date sort
alias la='exa -lhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa -lhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1' # one column, just names
alias lt='exa --tree --level=2' # tree

thefuck --alias | source


if status is-interactive
end
starship init fish | source
