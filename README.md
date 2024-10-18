# Server (debian) config.
Version of my dotfiles that is as minimal as possible, (hopefully) portable to any debian-based machine.

- Clone this into a bare repo on machine:
`git clone --bare <this-repo-url> $HOME/.cfg`

- The special alias is already in the `.bashrc`, but add it to the current shell scope:
`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

- Checkout the actual dotfiles to home:
`config checkout`
