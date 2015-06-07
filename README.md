# ck89119's vimrc

Author: Cao (ck89119) Kai <ck89119@gmail.com> inspired by vgod <https://github.com/vgod/vimrc>

## ONE-STEP INSTALL

Use curl:

     curl -o - https://raw.github.com/ck89119/.vim/master/auto-install.sh | sh

or wget:

     wget -O - https://raw.github.com/ck89119/.vim/master/auto-install.sh | sh


## MANUALLY INSTALL

1. Check out from github

        git clone git://github.com/ck89119/.vim.git ~/.vim
        cd ~/.vim
        git submodule update --init --recursive

2. Install YCM

        cd bundle/YouCompleteMe
        sudo apt-get install build-essential cmake
        sudo apt-get install python-dev
        ./install.sh --clang-completer
        
3. Install ~/.vimrc

        cd ~/.vim
        ./install-vimrc.sh

## INSTALL & UPGRADE PLUGIN BUNDLES

All plugins were checked out as git submodules, 
which can be upgraded with `git pull`. For example, to upgrade easymotion 

     cd ~/.vim/bundle/easymotion
     git pull

To install a new plugin as a git submoudle, type the following commands.

     cd ~/.vim
     git submodule add [GIT-REPOSITORY-URL] bundle/[PLUGIN-NAME]

## PLUGINS

* [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332): Pathogen let us install a plugin as a bundle in ~/.vim/bundle seprately.

* [NerdTree](http://www.vim.org/scripts/script.php?script_id=1658): A tree explorer plugin for navigating the filesystem.

  Useful commands:   
    `:Bookmark [name]` bookmark any directory as name   
    `:NERDTree [name]` open the bookmark [name] in Nerd Tree   
    `F6` toggle the NerdTree

* [nerdcommenter](https://github.com/scrooloose/nerdcommenter): Easy to (un)comment code.

  Useful commands:   
    `,cc` comment out the current line or text selected in visual mode   
    `,cu` uncomments the selected line(s)   

* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe): A code-completion engine for Vim.

* [UltiSnips](https://github.com/SirVer/ultisnips): The ultimate snippet solution for Vim.

  Useful commands:   
    `F9` active related snippet   

* [vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt): Deal with pairs of surroundings.

  Useful commands:   
    `cs"'` inside `"Hello world!"`, then `"Hello world!"` => `'Hello world!'`   

* [EasyMotion](https://github.com/Lokaltog/vim-easymotion): An easy way to jump to a word.

  Useful commands:   
    `,,w` forward EasyMotion   
    `,,b` backward EasyMotion   

* [TagBar](http://majutsushi.github.com/tagbar/): browsing the tags of source files ordered by classes.

  Useful commands:    
    `F7` toggle the TagBar

## Other good references

* https://github.com/vgod/vimrc
* http://amix.dk/vim/vimrc.html
* http://spf13.com/post/perfect-vimrc-vim-config-file
