REPO=https://github.com/vpc-network/zsh-custom.git

# install custom modules
if [ ! -d "$HOME/.oh-my-zsh/custom/.git" ]; then
  rm -rf $HOME/.oh-my-zsh/custom
  git clone $REPO $HOME/.oh-my-zsh/custom
fi

# pull module updates
git -C $HOME/.oh-my-zsh/custom pull
git -C $HOME/.oh-my-zsh/custom submodule update --init --recursive