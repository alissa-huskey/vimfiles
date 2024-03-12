dot-vim
=======

> My personal `.vim` / `.nvim` directory.

Files and Directories
---------------------

A brief explanation of what each file and directory is for.

| directory           | description                                                 |
|---------------------|-------------------------------------------------------------|
| `init.vim`          | base config file                                            |
| `after/`            | same filesystem structure, but loaded after everything else |
| `autoload/`         | lazy load functions                                         |
| `colors/`           | colorscheme files                                           |
| `ftdetect/`         | per-filetype for detecting filetypes                        |
| `ftplugin/`         | per-filetype general scripts                                |
| `indent/`           | per-filetype indent                                         |
| `pack/`             | plugins in the pack directory structure                     |
| `plugin/`           | any `.vim` file is loaded at startup                        |
| `    custom-colors/`| colorscheme customizations [^1]                             |
| `    functions/`    | files that contain vim functions                            |
| `    lua/`          | files that contain lua scripts                              |
| `    plugins/`      | for specific external plugins                               |
| `snippets/`         | snippets used with vim-snippets plugin                      |
| `spell/`            | spell checker dictionary additions                          |
| `syntax/`           | per-filetype syntax highlighting                            |
| `UltiSnips/`        | snippets used with the UltiSnips plugin                     |
|                     |                                                             |

[^1]: This directory can't be called `colors` because then it will interpret
      each file as its own colorscheme.
