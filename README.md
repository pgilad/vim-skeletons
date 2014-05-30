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

Source your `.vimrc` and then run `:NeoBundleInstall`.

## Usage

Either use the provided default skeletons dir or define your own.

You can define the skeletons dir like so:
```vim
let skeletons#skeletonsDir = "~/.dotfiles/vim/skeletons"
```

If make any changes after load to the skeletons directory or file,
you can reload the skeletons via `:SkeletonsReload`.

TODO

## API
TODO

## License

MIT License 2014 (©) Gilad Peleg
