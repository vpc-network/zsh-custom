# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
  if [ $FIRST_FOCUS -eq 0 ]; then
    zle -K vicmd
  fi
}

function zle-keymap-select {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
  if [ $FIRST_FOCUS -eq 0 ]; then
    export FIRST_FOCUS=1
  fi
}

function daw {
  zle backward-word
  zle delete-word
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line
zle -N daw

export KEYTIMEOUT=1
export FIRST_FOCUS=0

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey -M vicmd '^d' daw
bindkey -M vicmd '^h' vi-backward-word
bindkey -M vicmd '^l' vi-forward-word

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR_NORMAL" == "" ]]; then
  MODE_INDICATOR_NORMAL="%{$fg_bold[normal]%}<%{$fg[normal]%}<%{$fg[normal]%}<%{$reset_color%}"
fi

if [[ "$MODE_INDICATOR_INSERT" == "" ]]; then
  MODE_INDICATOR_INSERT="%{$fg_bold[yellow]%}>%{$fg[yellow]%}>%{$fg[yellow]%}>%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR_NORMAL}/(main|viins)/$MODE_INDICATOR_INSERT}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

