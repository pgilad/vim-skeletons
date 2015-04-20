# vim-skeletons

> Quickly scaffold template files in your favorite editor using UltiSnips templates

## Intro

This project is based on [skeletons.vim](https://github.com/tobyS/skeletons.vim) and expanded
from it.

The idea is to scaffold skeleton files when creating new files with vim, but add the power of
snippets generating using UltiSnips.

For any information on the snippets engine see [UltiSnips](https://github.com/SirVer/ultisnips)

## Installation

This plugin follows the standard runtime path structure, and can be installed with a variety of plugin managers:

#### [NeoBundle](https://github.com/Shougo/neobundle.vim)
`NeoBundle 'pgilad/vim-skeletons'`

#### [Pathogen](https://github.com/tpope/vim-pathogen)
`git clone https://github.com/pgilad/vim-skeletons ~/.vim/bundle/vim-skeletons`

#### [Vundle](https://github.com/gmarik/vundle)
`Plugin 'pgilad/vim-skeletons'`

#### [VAM](https://github.com/MarcWeber/vim-addon-manager)
`call vam#ActivateAddons([ 'vim-skeletons' ])`

####  Manual
copy all of the files into your `~/.vim` directory

## Usage

`vim-skeletons` is shipped with sample skeletons, thus you will need to either add your
own skeletons or add a skeleton repository.

**PRs for example skeletons will be happily accepted**

To activate `vim-skeletons` you can use `:SkeletonsOn`. Or just set in your `.vimrc`:
```vim
let skeletons#autoRegister = 1
```

You can change the skeletons directory:
```vim
let skeletons#skeletonsDir += "~/.dotfiles/vim/skeletons"
```

## Skeletons

### Loading and Filetypes

Skeletons are loaded from `skeletons#skeletonsDir`. They follow the following pattern: `skeleton-name.<extra>.<filetype>`, for example:

`skeleton.js` for Javascript files.
`skeleton.angular.js` for Angular.js Javascript files.
`skeleton.backbone.js` for Backbone.js Javascript files.
`skeleton.jquery.js` for Jquery Javascript files.

You can also have multiple skeletons for a filetype, and when you open a new file `vim-skeletons` will ask you which
skeleton you want to use for that filetype, the default being the file without the extra field. In our examples `skeleton.js`.

### Skeleton Details

A skeleton can be:
- A blank file
- A file with any text in it
- An `UltiSnips` template

After creating a new file, `vim-skeleton` will interpolate the skeleton using the `UltiSnips` engine,
thus allowing you to set defaults, use snippet structure and anything else you can think of.

An example skeleton `skeleton.php` is included:

```php
<?php

namespace ${1:`!v PathToNamespace(expand("%:h"))`};

class ${2:`!v expand("%:t:r")`}
{
    ${3}
}
```

## Global Commands

### SkeletonsOn

Call `:SkeletonsOn` to make `vim-skeletons` auto-register for creation of new files.

### SkeletonsOff

Call `:SkeletonsOff` to disable `vim-skeletons` for new files.

### SkeletonsReload

If make any changes to the skeletons directory or files you can reload them via `:SkeletonsReload`.

## License

MIT License 2015 ©Gilad Peleg
