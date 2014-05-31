# vim-skeletons

> Quickly scaffold template files in your favorite editor using UltiSnips templates

## Intro

This project is based on [skeletons.vim](https://github.com/tobyS/skeletons.vim) and expanded
from it.

The idea is to scaffold skeleton files when creating new files with vim, but add the power of
snippets generating using UltiSnips.

For any information on the snippets engine see [UltiSnips](https://github.com/SirVer/ultisnips)

## Installation

Recommended install using `NeoBundle`:

```vim
NeoBundle 'pgilad/vim-skeletons'
```

Then source your `.vimrc` and then run `:NeoBundleInstall`.

## Usage

`vim-skeletons` is shipped with a sample skeletons, thus your will need to either add your
own skeletons or add any skeleton repository.

To activate `vim-skeletons` you can use `:SkeletonsOn`. Or just set in your `.vimrc`:
```vim
let skeletons#autoRegister = 1
```

You can change the skeletons directory:
```vim
let skeletons#skeletonsDir += "~/.dotfiles/vim/skeletons"
```

## API

### SkeletonsOn

Call `:SkeletonsOn` to make `vim-skeletons` auto-register for creation of new files.

### SkeletonsOff

Call `:SkeletonsOff` to disable `vim-skeletons` for new files.

### SkeletonsReload

If make any changes after load to the skeletons directory or file,
you can reload the skeletons via `:SkeletonsReload`.

## License

MIT License 2014 (©) Gilad Peleg
