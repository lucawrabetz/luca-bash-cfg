# bash config.

- Clone this into a bare repo on machine:
```
git clone --bare <this-repo-url> $HOME/.cfg
```

- The special alias is already in the `.bashrc`, but add it to the current shell scope:
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

- Checkout the actual dotfiles to home:
```
config checkout
```

- Make sure to install vim-plug (following command works for user linux install for neovim):
```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

