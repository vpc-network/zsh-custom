# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.google/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.google/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.google/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.google/google-cloud-sdk/completion.zsh.inc"; fi
