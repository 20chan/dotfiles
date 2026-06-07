fpath+=($HOME/.zsh/pure)

autoload -U promptinit
promptinit

prompt pure

prompt_newline=" %666v"
PURE_PROMPT_SYMBOL="$"

zstyle :prompt:pure:host show no
zstyle :prompt:pure:title show no

zstyle :prompt:pure:custom:prefix color red
zstyle :prompt:pure:git:branch color yellow
zstyle :prompt:pure:path color green
zstyle :prompt:pure:git:dirty color yellow
zstyle :prompt:pure:prompt:success color white
zstyle :prompt:pure:prompt:error color red

print() {
  [[ $# -eq 0 && ${funcstack[-1]} = prompt_pure_precmd ]] || builtin print "$@"
}

host_prefix=
host_precmd() {
  host_prefix="C"
}
add-zsh-hook precmd host_precmd

precmd_pipestatus() {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
  else
    RPROMPT=
  fi
}
add-zsh-hook precmd precmd_pipestatus

prompt_pure_precustom() {
  # force hide username@hostname even ssh
  psvar[13]=""
  # hide arrow only
  psvar[17]=""
  psvar[22]=$host_prefix
}

