Be sure `dotfiles` is **cloned to the home directory**

## Get up and running
- `brew-app-installs.sh` installs brew and gets all the apps I need through brew

## Install Stow
`brew install stow`

## Run script
`./mac`

### Troubleshooting
`.DS_Store` errors:
close any finder windows you have open and run this to remove all `.DS_Store` folders
`find ~ -name ".DS_Store" -depth -exec rm -f {} \;`

