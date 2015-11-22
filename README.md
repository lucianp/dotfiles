Lucian's dotfiles
=================
My Linux / OS X dot files.

Introduction
------------
I finally decided to take some time and set up a git repository for all the
important dot files in my home directory.
At the moment I mainly want to manage my bash and Vim related files, but I might
add other stuff from time to time.
The files and scripts are MIT-licensed, so please feel free to use them whole or
parts of them in your setup.
This repository also contains third-party files (like Vim plugins, color schemes
and fonts) that might have their own licenses.

Installation
------------
Clone the repository in your home directory:

    git clone https://github.com/lucianp/dotfiles.git ~/dotfiles

Run the `install` script:

    ~/dotfiles/install

The script will symbolically link (`ln -s`) every file in the `~/dotfiles/link`
directory into the home directory `~/`.

Files having the same name as the symbolic links are backed up into the
`~/dotfiles/backup/<datetime>` directory.

License
-------
Copyright (c) 2015 Lucian Pestritu  
Licensed under the MIT license.

