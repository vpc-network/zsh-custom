export PYENV_DIR="$HOME/.pyenv"

if [ -d $PYENV_DIR/bin ]; then
  # export to path
  export PATH="$PYENV_DIR/bin:$PATH"

  # autoload pyenv
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi