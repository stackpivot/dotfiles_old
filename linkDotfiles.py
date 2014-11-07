# Das Script linkt die aufgefuehrten dotfiles in ~/. des Users per Softlink.
# Vorhandene Dotfiles werden in den .dotfiles.BAK/ Ordner verschoben.

import os

dotfiles = [
".config",
".gdbinit",
".linkDotfiles.py.swp",
".oh-my-zsh",
".pentadactyl",
".pentadactylrc",
"update.sh",
".vim",
".vimrc",
".Xdefaults",
".zshrc",
]


def checkForFileExistence(filepath):
    if filepath.split('/')[-1] in os.system("ls -la " + filepath):
        return True
    else:
        return False

for file in dotfiles:
    print('ln -s '+file)
    # os.system('ln -s'+dirname+'/'+file+' '+'~/'+file)
